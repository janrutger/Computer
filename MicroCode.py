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
            ("load_immediate", "PC", "arg1"), # Assuming arg1 is the target address
            ("set_cpu_state", "FETCH")
        ],
        # LD Instruction ld Rx Ry  (GPR)
        "30": [
            ("move_reg", "arg1", "arg2"),
            ("set_cpu_state", "FETCH")
        ],
        # LDI Instruction: ldi Rx value (general purpose registers)
        "31": [
            ("load_immediate", "arg1", "arg2"),
            ("set_cpu_state", "FETCH")
        ],
        # LDM Instruction: ldm Rx adres (general purpose registers)
        "32": [
            ("read_mem_adres", "arg2", "arg1"),
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
        "90": [
            ("move_reg", "Ra", "SP"),        # Move SP content to internal Ra
            ("store_mem_reg", "SP", "arg1"), # Store register content at new SP
            ("alu_dec",),                    # Decrement SP (Ra = Ra - 1)
            ("move_reg", "SP", "Ra"),        # Move decremented Ra back to SP
            ("set_cpu_state", "FETCH")
        ],
        # Example: POP (Pop stack to register) - one operand (register)
        "91": [
            ("move_reg", "Ra", "SP"),        # Move SP content to internal Ra
            ("alu_inc",),                    # Increment SP (Ra = Ra + 1)
            ("move_reg", "SP", "Ra"),        # Move incremented Ra back to SP
            ("read_mem_reg", "arg1", "SP"),   # read mem[sp] > R
            ("set_cpu_state", "FETCH")
        ]
    }
    return(rom)