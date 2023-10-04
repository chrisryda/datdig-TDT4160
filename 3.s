li t1, -1
add t1, t1, a0 # max d (A-1)
li t0, 1 # iterator value

loop_head:
    blt t1, t0, end
    rem s0, a0, t0
    beq s0, zero, is_divisor
    addi t0, t0, 1
    j loop_head  

is_divisor:
    mv s1, t0
    mul t2, t0, t0
    beq a0, t2, is_square    
    addi t0, t0, 1
    j loop_head
    
is_square:
    li a1, 1
    addi t0, t0, 1
    j loop_head

end:
    mv a0, s1
    li t0, 0
    li t1, 0
    li t2, 0
    li s0, 0
    li s1, 0
    