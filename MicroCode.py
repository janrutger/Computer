rom = {}

def init_rom():
    # This dictionary will store the microcode sequences for each instruction.
    # The keys are the instruction opcodes (as strings), and the values are lists
    # of microcode operations. Each microcode operation is a tuple where the
    # first element is the operation name (string) and subsequent elements are
    # its arguments.
    rom = {
        # NOP: No operation
        "10": [
            ("set_cpu_state", "FETCH")
        ],
        # HALT: Stop the CPU
        "11": [
            ("set_cpu_state", "HALT")
        ],
        # Example: JMP (Jump to address) - one operand (address)
        # This is a placeholder. Actual JMP would involve setting PC.
        "22": [
            ("move_reg", "PC", "arg1"), # Assuming arg1 is the target address
            ("set_cpu_state", "FETCH")
        ],
        # LDI Instruction: ldi Rx value (general purpose registers)
        "31": [
            ("load_immediate", "arg1", "arg2"),
            ("set_cpu_state", "FETCH")
        ],
        # STO instruction: sto Rx adres
        "40": [
            ("store_mem_adres", "arg2", "arg1"),
            ("set_cpu_state", "FETCH")
        ],
        # ADD Instruction: add Rx Ry (general purpose registers)
        "50": [
            ("move_reg", "Ra", "arg1"),
            ("move_reg", "Rb", "arg2"),
            ("alu_add",),
            ("move_reg", "arg1", "Ra"),
            ("set_cpu_state", "FETCH")
        ],
        # SUB instruction: sub Rx Ry
        "52": [
            ("move_reg", "Ra", "arg1"),
            ("move_reg", "Rb", "arg2"),
            ("alu_sub",),
            ("move_reg", "arg1", "Ra"),
            ("set_cpu_state", "FETCH")
        ],
        # Example: PUSH (Push register to stack) - one operand (register)
        # This is a placeholder. Actual PUSH would involve SP and memory write.
        "90": [
            ("move_reg", "Ra", "SP"),      # Move SP content to internal Ra
            ("move_reg", "Rb", "arg1"),    # Move arg1 to internal Rb
            ("alu_dec",),                  # Decrement SP (Ra = Ra - 1)
            ("move_reg", "SP", "Ra"),      # Move decremented Ra back to SP
            ("store_mem_reg", "SP", "Rb"), # Store register content at new SP
            ("set_cpu_state", "FETCH")
        ]
    }
    return(rom)