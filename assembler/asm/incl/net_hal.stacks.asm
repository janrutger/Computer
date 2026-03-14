# .HEADER
. $rx_ring 256
. $tx_ring 256
. $HAL.init_str_0 22
. $HAL.init_str_1 20
. $HAL.init_str_2 38

# .CODE

    MALLOC $nic_status      18375 ; R: Bit 0=LINK_UP
    MALLOC $nic_cmd         18376 ; W: 1=RESET, 2=ENABLE
    MALLOC $nic_addr        18377 ; R/W: Node ID
    MALLOC $nic_rx_base     18378 ; R/W: RX Ring Ptr
    MALLOC $nic_rx_head     18379 ; R: RX Head (Written by NIC)
    MALLOC $nic_rx_tail     18380 ; R/W: RX Tail (Written by Driver)
    MALLOC $nic_tx_base     18381 ; R/W: TX Ring Ptr
    MALLOC $nic_tx_head     18382 ; R/W: TX Head (Written by Driver)
    MALLOC $nic_tx_tail     18383 ; R: TX Tail (Written by NIC)
    MALLOC $nic_ring_sz     18384 ; R/W: Ring Size
    EQU ~RING_MASK          255   ; Mask for Ring Buffer wrapping
    EQU ~RING_SIZE          256   ; Ring Buffer Size

# .FUNCTIONS
@HAL.init
    ldi A $HAL.init_str_0
    stack A $DATASTACK_PTR
    call @PRINTSTRING

        ldi A 1             ; RESET CMD
        sto A $nic_cmd      ; Stop the hardware
        ldi A 0
        sto A $nic_rx_tail  ; Clear Driver RX Tail
        sto A $nic_tx_head  ; Clear Driver TX Head
    
        ldm A $nic_status   ; Load value from MMIO register
        andi A 1    ; Bitwise AND with 1 (Isolate Bit 0)
        stack A $DATASTACK_PTR    ; Push result back to stack
        ustack A $DATASTACK_PTR
    tst A 0
    jmpt :HAL.init_if_else_0
    ldi A $HAL.init_str_1
    stack A $DATASTACK_PTR
    call @PRINTSTRING

            ldi A $rx_ring      ; Load address of rx_ring
            sto A $nic_rx_base  ; Write to MMIO
            ldi A $tx_ring      ; Load address of tx_ring
            sto A $nic_tx_base  ; Write to MMIO
            ldi A ~RING_SIZE    ; RING_SIZE
            sto A $nic_ring_sz  ; Write to MMIO
            #leave the NIC in the RESET mode.
            # ldi A 2             ; Enable CMD
            # sto A $nic_cmd      ; Write to MMIO

            ldi A 1
            stack A $DATASTACK_PTR  ; Network is found
            jmp :HAL.init_if_end_0
:HAL.init_if_else_0
    ldi A $HAL.init_str_2
    stack A $DATASTACK_PTR
    call @PRINTSTRING

            ldi A 0
            stack A $DATASTACK_PTR ; Network is not found
        :HAL.init_if_end_0
    ret
@HAL.configure

        ustack A $DATASTACK_PTR ; read the hostname from the stack
        sto A $nic_addr         ; write hostname to NIC register

        ldi A 2                 ; Enable CMD
        sto A $nic_cmd          ; Write to MMIO
        nop                     ; Yield/Wait
        ret
@HAL.send_raw

        # Stack: [ ... data_ptr, length ]
        # Pop arguments
        ustack C $DATASTACK_PTR ; C = Length
        ustack A $DATASTACK_PTR ; A = Source Pointer (data_ptr)

        # Load Current TX Head from MMIO
        ldm B $nic_tx_head

        # --- 1. Write Length Prefix ---
        # The hardware requires the packet length [0..255] to be written
        # to the ring buffer before the packet data.
        
        :tx_wait_len
            # Calculate Next Head: K = (B + 1) % 256
            ld K B
            addi K 1
            andi K ~RING_MASK

            # Check for overflow: if Next Head == Tail, buffer is full
            ldm L $nic_tx_tail
            tste K L
            jmpt :tx_retry_len
            jmp :tx_write_len

        :tx_retry_len
            nop             ; Yield/Wait
            jmp :tx_wait_len

        :tx_write_len
            # Write Length (C) to Ring[B]
            # so the NIC knows the length of the current package
            ldi I $tx_ring
            add I B
            stx C $_start_memory_

            # Update Head (B) to Next (K)
            ld B K

        # --- 2. Copy Data Loop ---
        # Loop C times to copy data from Source(A) to Ring(B)

        :tx_loop
            tst C 0         ; If Length == 0, we are done
            jmpt :tx_done

            # -- Wait for space for next byte --
        :tx_wait_data
            ld K B
            addi K 1
            andi K ~RING_MASK

            ldm L $nic_tx_tail
            tste K L
            jmpt :tx_retry_data
            jmp :tx_write_data

        :tx_retry_data
            nop
            jmp :tx_wait_data

        :tx_write_data
            # Read Byte from Source (A)
            ld I A
            ldx M $_start_memory_

            # Write Byte to Ring (B)
            ldi I $tx_ring
            add I B
            stx M $_start_memory_

            # Advance Pointers
            ld B K          ; Head = Next
            addi A 1        ; Source++
            subi C 1        ; Length--
            jmp :tx_loop

        :tx_done
            # --- 3. Commit ---
            # Update the MMIO register to tell hardware we added data
            sto B $nic_tx_head
        ret
@HAL.rx_available

        # Load head and tail pointers from MMIO
        ldm A $nic_rx_head
        ldm B $nic_rx_tail

        # Assume no data (result = 0)
        ldi C 0

        # Compare them. If they are equal, T will be true.
        tste A B
        
        # If T is true (they are equal), jump to the end.
        jmpt :rx_available_done

        # Otherwise, data is available. Set result to 1.
        ldi C 1

    :rx_available_done
        # Push the result (0 or 1) to the stack.
        stack C $DATASTACK_PTR
        ret
@HAL.rx_peek_len

        # Load head and tail pointers
        ldm A $nic_rx_head
        ldm B $nic_rx_tail

        # Assume no data, length = 0
        ldi C 0

        # If head == tail, no data, jump to end
        tste A B
        jmpt :peek_done

        # Data is available. Read the length byte at the tail position.
        # The length is the first byte of the packet descriptor.
        ldi I $rx_ring
        add I B
        ldx C $_start_memory_

    :peek_done
        stack C $DATASTACK_PTR
        ret
@HAL.rx_copy_and_advance

        # Stack: [ ... dest_ptr ]
        ustack A $DATASTACK_PTR ; A = Destination Pointer

        # Load head and tail pointers
        ldm B $nic_rx_head
        ldm C $nic_rx_tail

        # If head == tail, no data, just return
        tste B C
        jmpt :copy_done

        # Read Packet Length (at Tail)
        ldi I $rx_ring
        add I C
        ldx X $_start_memory_ ; X = Packet Length

        # Advance Tail past length byte
        addi C 1
        andi C ~RING_MASK

        # Loop X times to copy data
        ld K X ; K = Loop Counter
    :copy_loop
        tst K 0
        jmpt :copy_commit

        # Read byte from Ring[C]
        ldi I $rx_ring
        add I C
        ldx M $_start_memory_

        # Write byte to Dest[A]
        ld I A
        stx M $_start_memory_

        # Advance pointers
        addi C 1            ; Ring index++
        andi C ~RING_MASK   ; Wrap
        addi A 1            ; Dest ptr++
        subi K 1            ; Counter--
        jmp :copy_loop

    :copy_commit
        # Commit the new tail pointer to hardware
        sto C $nic_rx_tail

    :copy_done
        # Nothing to do
        ret
@HAL.rx_skip_and_advance

        # Load head and tail pointers
        ldm A $nic_rx_head
        ldm B $nic_rx_tail

        # If head == tail, no data, just return
        tste A B
        jmpt :skip_done

        # Read Packet Length (at Tail)
        ldi I $rx_ring
        add I B
        ldx X $_start_memory_ ; X = Packet Length

        # Calculate new tail position: (Tail + 1 + Length) % Size
        addi B 1            ; Skip length byte
        add B X             ; Skip payload
        andi B ~RING_MASK   ; Wrap

        # Commit new tail to hardware
        sto B $nic_rx_tail

    :skip_done
        # Nothing to do
        ret
@PRINTSTRING

        # pointer to the string at the datastack
        # Read Pointer in A
        ustack A $DATASTACK_PTR

        :loop_printstring
            ld I A                ; Load address from A into I (R0)
            ldx C $_start_memory_ ; Load character from memory[start_memory + I] into C
            tst C \null           ; Check for null terminator
            jmpt :end_printstring ; If null, end loop

            call @print_char      ; Directly call print_char routine

            addi A 1              ; Increment string address
            jmp :loop_printstring ; Continue loop
        :end_printstring
        ret

# .DATA
% $HAL.init_str_0 \I \n \i \t \i \a \l \i \z \i \n \g \space \S \t \e \r \n \n \e \t \null
% $HAL.init_str_1 \, \space \L \i \n \k \space \S \t \a \t \u \s \: \space \U \P \Return \Return \null
% $HAL.init_str_2 \, \space \L \i \n \k \space \S \t \a \t \u \s \: \space \D \O \W \N \space \( \C \h \e \c \k \space \v \S \w \i \t \c \h \) \Return \Return \null
