.data

test_mode: .word   0
verbose:   .word   1

# Don't touch
w_c:       .word   0xb5ad4ece
mask:      .word   0xFFFF

# Print strings
str1:      .string "Value "
str2:      .string " stored at "
str3:      .string "Highest number: "

.text

lw a7, test_mode
beq a7, zero, load_complete

# TEST - START
li a0, 0xbeef
li a1, 3
# TEST - END

load_complete:
j main

# Function: msws32
# Generates a random number in range [0, 2^16 - 1]
msws32:
    mul a0, a0, a0
    lw t0, w_c
    add a1, a1, t0
    add a0, a0, a1
    slli t0, a0, 16
    srli t1, a0, 16
    or a0, t0, t1
    lw t0, mask
    and a0, a0, t0
    ret

# Function: fill_array_with_random_numbers
# Fills an allocated array with random numbers genereated by function msws32
fill_array_with_random_numbers:
    addi sp, sp, -24
    sw ra, 0(sp)
    sw a2, 4(sp)
    sw a3, 8(sp)
    li a4, 0

fawrn_loop_start:
    lw t0, 8(sp)
    bge a4, t0, fawrn_loop_end
    
    sw a4, 12(sp)
    call msws32
    lw a4, 12(sp)

    li t0, 4 # Word in bytes
    mul t0, a4, t0
    add t0, a2, t0
    sw a0, 0(t0)
    
    lw t1, verbose
    beq t1, zero, fawrn_skip_print
# Else
    sw a4, 12(sp)
    sw a0, 16(sp)
    sw a1, 20(sp)
    mv a0, a0
    mv a1, t0
    call print_put_at_adress
    lw a4, 12(sp)
    lw a0, 16(sp)
    lw a1, 20(sp)
    
fawrn_skip_print:
    addi, a4, a4, 1
    j fawrn_loop_start
    
fawrn_loop_end:
    lw ra, 0(sp)
    addi sp, sp, 24
    ret

# Function: print_put_at_adress
# Prints the address in a1 and value in a0
print_put_at_adress:
    mv t0, a0
    mv t1, a1
    la a0, str1
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall
    la a0, str2
    li a7, 4
    ecall
    mv a0, t1
    li a7, 34
    ecall
    li a0, 10
    li a7, 11
    ecall
    ret
    
# Function: print_max
# Prints the value in a0
print_max:
    mv t0, a0
    la a0, str3
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall
    li a0, 10
    li a7, 11
    ecall
    ret

# Function: find_max
# Input: a0 = stack/array start, a1 = length
# Finds max value in allocaled array and stores it in a0
find_max:
    li a2, 0
    lw a3, 0(a0)

fm_loop_start:
    bge a2, a1, fm_loop_end
    
    li s9, 4
    mul s9, s9, a2
    add s9, s9, a0
    lw s10, 0(s9)
     
    bge s10, a3, swap
    j skip

swap:
    mv a3, s10

skip:
    addi a2, a2, 1
    j fm_loop_start

fm_loop_end:
    mv a0, a3
    ret
    
# Main
# Input:a0 = seed, a1 = array length    
main:
    mv a3, a1
    mv s3, a3
    li a1, 0
    li t0, -4
    mul t0, a3, t0
    add sp, sp, t0 # Allocated
    mv a2, sp
    mv s2, a2
    call fill_array_with_random_numbers
        
    mv a0, s2
    mv a1, s3
    call find_max
    mv s0, a0
    # a0 -> a0
    call print_max
    mv a0, s0

clear_registers:
    li t0, 0
    li t1, 0
    li s0, 0
    li s2, 0
    li s3, 0
    li s9, 0
    li s10, 0
    li a1, 0
    li a2, 0
    li a3, 0
    li a4, 0
    li a7, 0
    
    nop
