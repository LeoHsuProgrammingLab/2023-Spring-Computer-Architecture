.globl __start

.rodata
    division_by_zero: .string "division by zero"
    
.data
    JumpTable: .word addition, minus, multiply, division, minimum, power, factorial

.text
__start:
    # Read first num
    li a0, 5
    ecall
    mv s0, a0
    # Read operation
    li a0, 5
    ecall
    mv s1, a0
    # Read second num
    li a0, 5
    ecall
    mv s2, a0
    # calculate the problem
    mv s3, s0
    jal x1, calculate
    jal x0, output

###################################
#  TODO: Develop your calculator  #
#                                 #
###################################
calculate:
    # Allocate memory for 4 bytes
    addi sp, sp, -4
    sw x1, 0(sp)#save x1 in the stack pointer sp
    # check the scale of 0 to 7
    slt x5, s1, x0
    bne x5, x0, exit
    slti x5, s1, 7
    beq x5, x0, exit
    # load address of JumpTable[0]
    la x28, JumpTable
    slli x5, s1, 2
    add x6, x5, x28
    lw x7, 0(x6)
    # Go to JumpTable
    jalr x0, 0(x7)
    lw x1, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
     
addition:
    add s3, s0, s2
    jalr x0, 0(x1)
     
minus:
    sub s3, s0, s2
    jalr x0, 0(x1)
    
multiply:
    mul s3, s0, s2
    jalr x0, 0(x1)
    
division:
    beq s2, x0, division_by_zero_except
    div s3, s0, s2
    jalr x0, 0(x1)
    
minimum:
    slt x5, s0, s2
    beq x5, x0, returnS2
    add s3, x0, s0
    jalr x0, 0(x1)
returnS2:
    add s3, x0, s2
    jalr x0, 0(x1)
    
power:
    beq s2, x0, power_0
    li x5, 1
    beq s2, x5 power_self
    #general cases
    addi sp, sp, -4
    sw x1, 0(sp)
    mul s3, s3, s0
    addi s2, s2, -1
    jal x1, power
    lw x1, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
    
power_0:
    li s3, 1
    jalr x0, 0(x1)

power_self:
    jalr x0, 0(x1)
    
factorial:
    beq s0, x0, factorial_0
    li x6, 1
    beq s0, x6, factorial_1
    #general cases
    addi sp, sp, -4
    sw x1, 0(sp)
    addi s0, s0, -1
    mul s3, s3, s0
    jal x1, factorial
    lw x1, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)
    
factorial_0:
    li s3, 1
    jalr x0, 0(x1)

factorial_1:
    jalr x0, 0(x1)

output:
    # Output the result
    li a0, 1
    mv a1, s3
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

division_by_zero_except:
    li a0, 4
    la a1, division_by_zero
    ecall
    jal zero, exit
