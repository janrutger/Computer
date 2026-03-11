# .HEADER
. $rx_ring 256
. $tx_ring 256
. $net_port_map 1
. $net_packet_pool 1
. $_rx_dest_deque 1
. $NET.init_str_0 22
. $NET.init_str_1 20
. $NET.init_str_2 38

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
    
    . $net_is_configured    1   ; Size 1
    % $net_is_configured    0   ; Value 0 (Not Configured)


# .FUNCTIONS
@NET.init
    ldi A $NET.init_str_0
    stack A $DATASTACK_PTR
    call @PRINTSTRING

        ldi A 1             ; RESET CMD
        sto A $nic_cmd      ; Stop the hardware
        ldi A 0
        sto A $nic_rx_tail  ; Clear Driver RX Tail
        sto A $nic_tx_head  ; Clear Driver TX Head
        sto A $net_port_map ; Clear Port Map Pointer
        sto A $net_packet_pool ; Clear Pool Pointer
    
        ldm A $nic_status   ; Load value from MMIO register
        andi A 1    ; Bitwise AND with 1 (Isolate Bit 0)
        stack A $DATASTACK_PTR    ; Push result back to stack
        ustack A $DATASTACK_PTR
    tst A 0
    jmpt :NET.init_if_else_0
    ldi A $NET.init_str_1
    stack A $DATASTACK_PTR
    call @PRINTSTRING

            ldi A $rx_ring      ; Load address of rx_ring
            sto A $nic_rx_base  ; Write to MMIO
            ldi A $tx_ring      ; Load address of tx_ring
            sto A $nic_tx_base  ; Write to MMIO
            ldi A ~RING_SIZE    ; RING_SIZE
            sto A $nic_ring_sz  ; Write to MMIO
            ldi A 2             ; Enable CMD
            sto A $nic_cmd      ; Write to MMIO

            ldi A 1
            sto A $net_is_configured ; Network is found
            jmp :NET.init_if_end_0
:NET.init_if_else_0
    ldi A $NET.init_str_2
    stack A $DATASTACK_PTR
    call @PRINTSTRING

            ldi A 0
            sto A $net_is_configured ; Network is not found
        :NET.init_if_end_0
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
@NET.send

        # A = packet_ptr, C = Length
        ustack A $DATASTACK_PTR
        ld I A
        ldx C $_start_memory_   ; Load Packet Length
        
        # B = Current Ring Head (Local Copy)
        ldm B $nic_tx_head
        
        # --- Step 1: Write Length Byte ---
        :tx_wait_len
            # Calculate Next Head (B+1)
            ld K B
            addi K 1
            andi K ~RING_MASK
            
            # Check if Full (Next == Tail)
            ldm L $nic_tx_tail
            tste K L
            jmpt :tx_retry_len  ; Full -> Wait
            jmp :tx_write_len

        :tx_retry_len
            nop
            jmp :tx_wait_len

        :tx_write_len
            # Write Length (C) to Ring[B]
            ldi I $tx_ring
            add I B
            stx C $_start_memory_
            
            ld B K              ; Advance Head (B = Next)

        # --- Step 2: Copy Data Loop ---
        addi A 1                ; Advance Source Pointer to first data byte
        
        :tx_loop
            tst C 0             ; Check if Count is 0
            jmpt :tx_done
            
            # Get Byte from Source (A)
            ld I A
            ldx M $_start_memory_
            
            # Wait for Space (Next Byte)
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
                # Write Byte (M) to Ring[B]
                ldi I $tx_ring
                add I B
                stx M $_start_memory_
                
                ld B K          ; Advance Head (B = Next Head from K)
                addi A 1        ; Advance Source
                subi C 1        ; Decrement Count
                jmp :tx_loop

        :tx_done
            # 4. Commit New Head to MMIO
            sto B $nic_tx_head
            
            # 5. Return Success (1)
            ldi A 1
            stack A $DATASTACK_PTR
        ret
@NET.bind

        # 1. Check if Map exists (Lazy Init)
        ldm A $net_port_map
        tst A 0
        jmpf :bind_do_put   ; If not 0, proceed
        
        # Create Dictionary (Capacity 16)
        ldi A 16
        stack A $DATASTACK_PTR
        call @DICT.new
        ustack A $DATASTACK_PTR
        sto A $net_port_map

    :bind_do_put
        # Stack: [ ... port_id, deque_ptr ]
        # DICT.put expects: ( value key dict_ptr -- )
        # We want: ( deque_ptr port_id net_port_map -- )
        
        call @rt_swap           ; Swap to: [ ... deque_ptr, port_id ]
        ldm C $net_port_map
        stack C $DATASTACK_PTR  ; Push Dict Ptr
        call @DICT.put
        ret
@NET.recv

        # --- Lazy Initialization of Packet Pool ---
        ldm A $net_packet_pool
        tst A 0
        jmpf :rx_start

        # Create Pool Deque
        call @DEQUE.new
        ustack A $DATASTACK_PTR
        sto A $net_packet_pool

        # Fill Pool with 16 buffers of size 256
        ldi C 0
    :rx_pool_fill
        ldi A 16
        tste C A
        jmpt :rx_start
        ldi A 256
        stack A $DATASTACK_PTR
        call @NEW.array
        call @NET.free_buffer   ; Push back to pool
        addi C 1
        jmp :rx_pool_fill

    :rx_start
        # Initialize Count = 0
    stack Z $DATASTACK_PTR

    :rx_loop
        # 1. Check if Data Available (Head != Tail)
        ldm B $nic_rx_head
        ldm C $nic_rx_tail
        tste B C
        jmpt :rx_done       ; If equal, no more data

        # 2. Read Packet Length (at Tail)
        ldi I $rx_ring
        add I C             ; I = Base + Tail
        ldx X $_start_memory_ ; X = Packet Length

        # 3. Peek at Destination Port (LSB at Offset 11 in Header)
        # Header starts at Tail + 1. Port LSB is at Tail + 1 + 11 = Tail + 12
        ld K C              ; K = Tail
        addi K 12           ; Offset to Port LSB
        andi K ~RING_MASK   ; Wrap
        
        ldi I $rx_ring
        add I K
        ldx Y $_start_memory_ ; Y = Port ID

        # 4. Lookup Port in Map
        # Stack: [ Count ] -> Push [ Port, Map ]
        stack Y $DATASTACK_PTR
        ldm A $net_port_map
        stack A $DATASTACK_PTR
        call @DICT.has_key
        
        # Check Result
        ustack A $DATASTACK_PTR ; A = 1 (Found) or 0 (Not Found)
        tst A 0
        jmpt :rx_drop       ; Port not bound -> Drop Packet

        # 5. Port Found: Get Deque Ptr
        stack Y $DATASTACK_PTR  ; Push Port
        ldm A $net_port_map
        stack A $DATASTACK_PTR  ; Push Map
        call @DICT.get
        ustack A $DATASTACK_PTR
        sto A $_rx_dest_deque   ; Save the destination deque pointer

        # 6. Get Buffer from Pool
        ldm B $net_packet_pool
        stack B $DATASTACK_PTR
        call @DEQUE.is_empty
        ustack B $DATASTACK_PTR
        tst B 0
        jmpf :rx_drop           ; If empty (1), drop packet
        ldm B $net_packet_pool
        stack B $DATASTACK_PTR
        call @DEQUE.pop         ; Returns Ptr
        ustack B $DATASTACK_PTR ; B = Packet Buffer Ptr

        # 7. Copy Data (Ring -> Buffer)
        # Buffer structure: [Cap, Count, Data...]
        # We write directly to Data area (Ptr + 2)
        
        # Setup Copy Pointers
        ld K C              ; K = Ring Index for copy (from Tail)
        addi K 1            ; Skip Length Byte
        andi K ~RING_MASK
        
        ld L B              ; L = Buffer Index for copy
        addi L 2            ; Skip Array Header
        
        ld M X              ; M = Bytes to Copy (from Length)

    :rx_copy_loop
        tst M 0
        jmpt :rx_copy_done
        
        # Read from Ring
        ldi I $rx_ring
        add I K
        ldx Y $_start_memory_   ; Use Y as temp for the byte
        
        # Write to Buffer
        ld I L
        stx Y $_start_memory_
        
        # Advance
        addi K 1
        andi K ~RING_MASK
        addi L 1
        subi M 1
        jmp :rx_copy_loop

    :rx_copy_done
        # Update Array Count (Header 1) manually since we bypassed append
        ld I B
        addi I 1
        stx X $_start_memory_ ; Store Length (X) into Array.Count

        # 8. Deliver to Deque
        stack B $DATASTACK_PTR  ; Value (Packet Ptr)
        ldm A $_rx_dest_deque   ; Restore the destination deque pointer
        stack A $DATASTACK_PTR
        call @DEQUE.append


    :rx_drop
        # 9. Advance Tail (Tail + 1 + Length)
        # +1 for the Length byte itself
        ldm C $nic_rx_tail
        addi C 1
        add C X             ; Add Packet Length
        andi C ~RING_MASK
        sto C $nic_rx_tail  ; Update MMIO

        # Increment Processed Count
        ustack A $DATASTACK_PTR
        addi A 1
        stack A $DATASTACK_PTR
        
        jmp :rx_loop

    :rx_done
        # Return Count is already on stack
        ret
@NET.free_buffer

        ustack A $DATASTACK_PTR ; Buffer Ptr
        stack A $DATASTACK_PTR
        ldm B $net_packet_pool
        stack B $DATASTACK_PTR
        call @DEQUE.append
        ret

# .DATA
% $net_port_map 0
% $net_packet_pool 0
% $_rx_dest_deque 0
% $NET.init_str_0 \I \n \i \t \i \a \l \i \z \i \n \g \space \S \t \e \r \n \n \e \t \null
% $NET.init_str_1 \, \space \L \i \n \k \space \S \t \a \t \u \s \: \space \U \P \Return \Return \null
% $NET.init_str_2 \, \space \L \i \n \k \space \S \t \a \t \u \s \: \space \D \O \W \N \space \( \C \h \e \c \k \space \v \S \w \i \t \c \h \) \Return \Return \null
