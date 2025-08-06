I like to write an cpu/computer simulation where instruction of the CPUś isa are designed as an small microcode programs who are running on the core of the cpu, in python. The CPU works with decima numbers


the computer has 4K of RAM memory and an CPU where the CPU executes on every tick an mictrocode instruction
The CPU is following the ´standard' fetch-decode-execute cycle

The CPU has 10 general purpose register R0 - R9 where R0 is also the desinated Index register
The CPU has an Zero-flag, a negative-flag, and an equal_flag (since the similation works with variable lenght values, carry-flag and overflow-flag are not needed)
special registers PC=Programcounter, SP=Stackpointer, IR=Instructionregister


The CPU has 3 type of instructions, the opcode followed by:
    Zero operand, like: halt, nop, ret
    One  operand, like: jmp, call, push, pop
    Two  operand, like: add, sub, ld, sto, tst, mv

The ISA has maximum of 90 instructions, indicated by an number 10 .. 99
this is an example of the ISA

	0	1	2	3	4	5	6	7	8	9
1	NOP	HALT 	RET	EI	DI	RTI				
2	JMPF	JMPT	JMP	JMPX	CALL	CALLX	INT	CXTSW		
3	LD	LDI	LDM	LDX						
4	STO	STX								
5	ADD	ADDI	SUB 	SUBI	SUBR					
6	MUL	MULI	DIV	DIVI	DIVR	DMOD				
7	TST	TSTE	TSTG							
8	INC	DEC	ANDI	XORX						
9	PUSH	POP								



The memory stores the data as variable lenght numeric strings, "15879" is valid, and "dg4895" is not

the insctruction decoding 

Zero Operand
    opcode                      eg nop = "10", halt = "11"

one operand
    opcode+adres                eg jmp  10 = "2210"
    opcode+register             eg push R2 = "902"

two operand
    opcode+register+adres       eg inc  R0 100 = "800100"
    opcode+register+register    eg add  R2 R1  = "5021"
    opcode+register+value       eg addi R4 42  = "51442"


The ISA is taking care of the different adressing methods by having an instruction per method.
like LD LDI LDM LDX

the microcode is executed by the executer, for each CPU instrcuction, ISA + fetching, an sequence of
microcode instructions is stored in an python dictonary, acting as an rom-file
the executer is called with the code to execute and the (max 2) arguments

eg nop = "10"           -> executer(10) 
eg push R2 = "902"      -> executer(9, 2)
eg add  R2 R1  = "5021" -> executer(50, 2, 1)



An Overview proces cycle

Initial state of the CPU is FETCH
    While fetching
        mem_read_reg(PC, IR)
        move_reg(Ra, PC)
        alu_inc
        move_reg(PC, Ra)

    The new state of the CPU is DECODE

While decoding 
    in Python: split the value in the IR register to opcode, arg1, arg2
    and start the executer with the given arguments

    The next state of the CPU is EXECUTE

While executing
    the executer runs one microcode instruction per cycle and keeps the status of the CPU on EXECUTE
    after finish the microcode the CPU state is set to FETCH


Supported microcode instructions


read_mem_reg(Rx, Ry)            eg mem_read_reg(PC, IR) Reads the memory adres in PC and place the value in IR
read_mem_adres(adres, Rx)       eg mem_read_adres(42, R3) Reads the memory adres 42 and place the value in R3

*load_immediate(Rx, value)       eg load_immediate(R9, 42)  loading 42 in register R9
*move_reg(Rx, Ry)                moves Ry into Rx 
                                eg move_reg(Ra, R6) moves facing R6 into internal register Ra
                                eg move_reg(Rb, R7) moves facing R7 into internal register Rb
*alu_add                         Ra + Rb -> Ra (set status flags)
*alu_sub                         Ra - Rb -> Ra (set status flags)
alu_mul                         Ra * Rb -> Ra (set status flags)
alu_div                         Ra / Rb -> Ra (set status flags)
alu_inc                         Ra + 1  -> Ra (set status flags)
alu_dec                         Ra - 1  -> Ra (set status flags)
alu_cmp                         set status flags


store_mem_reg(Rx, Ry)           Stores the value of Ry at the adres in Rx
*store_mem_adres(adres, Rx)      Stores the value of Rx at the adres

bra(n-lines)                    branch Always   (plus or minus lines in the microcode)
brz(n-lines)                    branch Zero     (plus or minus lines in the microcode)
brn(n-lines)                    branch Negative (plus or minus lines in the microcode)
beq(n-lines)                    branch Equal    (plus or minus lines in the microcode)


 computer
    memory
    cpu(memory)
        general purpose registers (GPR)
        Special Registers         (SR)
        Flags                     (FLAGS)
        core(microcode, memory, GPR, SR, FLAGS)
(future)
    keyboard(memory)
    display(memory)
    SIO(memory)