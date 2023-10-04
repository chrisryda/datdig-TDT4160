start:
    add a0, a0, a1
    add a2, a2, a3
    add a4, a4, a5
    
    bge a2, a0, swap1
    j skip
 
swap1:
    mv a0, a2

skip:
    bge a4, a0, swap2
    j finish
       
swap2:
    mv a0, a4
    
finish:
    li a1, 0
    li a2, 0
    li a3, 0
    li a4, 0
    li a5, 0
    li a5, 0
