.data
test_data:
    size: .word 3                # Size of test data
    arr: .word 1, 2, 3          # Test data array
    str1: .string " Gray code for n = "
    newline: .string "\n"

.text
.global _start
_start:
    la t0, test_data             
    lw t1, 0(t0)                 # Load size
    addi t0, t0, 4               # Move to data array

process_data:
    beqz t1, end_program         

    lw a1, 0(t0)                 # Load current n value
    addi t0, t0, 4               
    addi t1, t1, -1              

    la a0, str1                  
    li a7, 4                     
    ecall

    mv a0, a1                    
    li a7, 1                     
    ecall

    li t2, 1                     
    sll t2, t2, a1               

    li t3, 0                     

generate_gray_code:
    bge t3, t2, process_data     

    srli t4, t3, 1               
    xor t5, t3, t4               

    mv a0, t5                    
    li a7, 1                     
    ecall

    la a0, newline               
    li a7, 4                     
    ecall

    addi t3, t3, 1               
    j generate_gray_code         

end_program:
    li a7, 10                    
    ecall
