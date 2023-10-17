li a0, 1
li a1, 1
li a2, 1
li a3, 1
li a4, 1
li a5, 2

j main

swap:
    bge a1, a0, swap_complete
    mv t0, a0
    mv a0, a1
    mv a1, t0
    li s6, 1
    
swap_complete:
    ret
    
main:
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5
    
loop:
    li s6, 0
    
    mv a0, s0
    mv a1, s1
    call swap
    mv s0, a0
    mv s1, a1
    
    mv a0, s1
    mv a1, s2
    call swap
    mv s1, a0
    mv s2, a1
    
    mv a0, s2
    mv a1, s3
    call swap
    mv s2, a0
    mv s3, a1
    
    mv a0, s3
    mv a1, s4
    call swap
    mv s3, a0
    mv s4, a1
    
    mv a0, s4
    mv a1, s5
    call swap
    mv s4, a0
    mv s5, a1
    
    beq s6, zero, loop_end
    j loop
    
loop_end:
    mv a0, s0
    mv a1, s1
    mv a2, s2
    mv a3, s3
    mv a4, s4
    mv a5, s5
    
    li t0, 0
    li s0, 0
    li s1, 0
    li s2, 0
    li s3, 0
    li s4, 0
    li s5, 0
    li s6, 0
    