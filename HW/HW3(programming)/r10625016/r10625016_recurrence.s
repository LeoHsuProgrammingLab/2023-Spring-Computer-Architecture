.global __start

.rodata 
  Jumptable: .word fibonacci
  
.text
__start:
  # read number n
  li a0, 5
  ecall
  mv s0, a0
  jal x1, rec
  jal x0, output

rec:
  # check the scale from 0 to 15
  slt x5, s0, x0 # set less than 
  bne x5, x0, exit
  slti x5, s0, 16
  beq x5, x0, exit
  # if n = 1
  li x5, 1
  beq s0, x5, rec_1
  # if n = 0
  beq s0, x0, rec_0
  # general case and recursively call
  addi sp, sp, -12
  sw x1, 0(sp)
  sw s0, 4(sp)
  # 2*T(n-1)
  addi s0, s0, -1
  jal x1, rec
  mv s2, s1
  sw s2, 8(sp)
  # T(n-2)
  lw s0, 4(sp)
  addi s0, s0, -2
  jal x1, rec
  mv s3, s1
  # conquer
  li s5, 2
  lw s2, 8(sp)
  mul s2, s2, s5
  add s1, s3, s2
  # get back 
  lw x1, 0(sp)
  addi sp, sp, 12
  jalr x0, 0(x1)
  
rec_1:
  li s1, 1
  jalr x0, 0(x1)

rec_0:
  li s1, 0
  jalr x0, 0(x1)
  
output:
    # Output the result
    li a0, 1 # a0 = 1
    mv a1, s1 # output a1
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall