.globl	__start

.rodata
        msg: .asciiz "Empty!"
.text

push_front_list:             
        ### if(list == NULL)return; ###
        beqz    a0, LBB0_2 # be equal to zero
        ### save ra(x1)、s0 ###
        addi    sp, sp, -16
        sw      ra, 12(sp)                      
        sw      s0, 8(sp)                       
        sw      s1, 4(sp)                       
        mv      s1, a1 # s1 is the value from input a1
        mv      s0, a0 # and s0 is the address from original head addr "sp"
        ### node_t *new_node = (node_t*)sbrk(sizeof(*new_node)); ###
        li      a0, 8
        call    sbrk
        ### new_node->value = value; ###
        sw      s1, 0(a0)
        ### new_node->next = list->head; ###
        lw      a1, 0(s0) # dump the original head to 4(a0)
        sw      a1, 4(a0)
        ### list->head = new_node; ###
        sw      a0, 0(s0)
LBB0_2:
        ## exit handling ###
        lw      ra, 12(sp)                      
        lw      s0, 8(sp)                       
        lw      s1, 4(sp)                       
        addi    sp, sp, 16
        ret # the return addr is set to be ra, and return to ra
        
print_list:
############################################
#  TODO:Print out the linked list          #
#                                          #
############################################ 
        beqz a0, LBB2_4
        addi sp, sp -8
        sw ra, 0(sp)
        sw a0, 4(sp)
        lw a0, 4(a0)
        call print_list
        lw a0, 4(sp)
        call print_int
        lw ra, 0(sp)
        addi sp, sp, 8
        jalr x0, 0(ra)
        
__start:
        ### save ra、s0 ###                                   
        addi    sp, sp, -16
        sw      ra, 12(sp)                      
        sw      s0, 8(sp)                                            
        ### read the numbers of the linked list ###
        call    read_int
        ### if(nums == 0) output "Empty!" ###
        beqz    a0, LBB2_2
        ### if(nums <= 0) exit
        mv      s0, a0
        blez    a0, exit
        # general cases
        jal ra, LBB2_1
LBB2_1:                                
        call    read_int
        ### set push_front_list argument ###
        mv      a1, a0 # turn a1 as the input value
        mv      a0, sp # a0 turns out to be the addr
        call    push_front_list
        addi    s0, s0, -1
        bnez    s0, LBB2_1
        lw      a0, 0(sp)
        j       LBB2_3
LBB2_2:
        call    print_str
        j       exit
LBB2_3:
        call    print_list
        call    exit
LBB2_4:
        ret
exit:   
        ### exit handling ###
        li      a0, 0
        lw      ra, 12(sp)                      
        lw      s0, 8(sp)                       
        addi    sp, sp, 16
	li a0,	10
	ecall

read_int:
	li	a0, 5
	ecall
	jr	ra

sbrk:
	mv	a1, a0
	li	a0, 9
	ecall
	jr	ra
 
print_int:
	lw 	a1, 0(a0)
	li	a0, 1
	ecall
	li	a0, 11
	li	a1, ' '
	ecall
	jr	ra

print_str:
        li      a0, 4
        la      a1, msg
        ecall
        jr      ra