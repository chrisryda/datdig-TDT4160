li t1, -1
add t1, t1, a0 # max gcd (A-1)
li t0, 1 # iterator value

loop_head:
    blt t1, t0, loop_end
    rem s0, a0, t0
    beq s0, zero, swap
    addi t0, t0, 1
    j loop_head  

swap:
    mv s1, t0
    addi t0, t0, 1
    j loop_head

loop_end:
    mv a0, s1
    
    li t0, 0
    li t1, 0
    li s0, 0
    li s1, 0
    