    .data
prompt:     .asciiz "Please insert element "
new_line:   .asciiz "\n"
output_msg: .asciiz "Second largest value is "
index_msg:  .asciiz ", found in index "
arr:        .space 40          # tao cho cho 10 integer (moi cai 4 byte)

    .text
main:

    la   $t0, arr              # gan dia chi mang arr vao t0
    li   $t1, 1                # bien dam 
    
input_loop:
    li   $v0, 4                # Print string syscall
    la   $a0, prompt           # Load prompt message
    syscall                    # Print "Please insert element "

    li   $v0, 1                # Print integer syscall for the element number
    move $a0, $t1              # Move the element number to $a0
    syscall                    # Print the element number
    
    addi $a0, $0, ':' 
    li $v0, 11 #in dau cach
    syscall
    
    addi $a0, $0, ' ' 
    li $v0, 11 #in dau cach
    syscall

    li   $v0, 5                # Read integer syscall
    syscall                    # Read the user input
    sw   $v0, 0($t0)           # Store the input in the array at position $t0

    addi $t0, $t0, 4           # Move to the next array position
    addi $t1, $t1, 1           # Increment element number
    li   $t2, 11               # Exit condition (counter should be <= 10)
    slt  $t9, $t1, $t2
    bne  $t9, $0, input_loop
###########################################################################################################################################################################
    
    la   $t0, arr 
    lw   $t1, 0($t0)
    add  $t2, $t1, $0
    li   $t3, 1
    
    
lon_nhat:
    add  $t0, $t0, 4
    addi $t3, $t3, 1 
    lw   $t1, 0($t0)
    slt  $t4, $t2, $t1 
    beq  $t4, $zero, notLargest
    add  $t2, $t1, $0
notLargest:
    li   $t5, 10
    slt  $t9, $t3, $t5
    bne  $t9, $0, lon_nhat
    
    #add  $a0, $zero, $t2
    #li   $v0, 1
    #syscall

    la   $t0, arr 
    add  $t4, $zero, $zero
    add  $t4, $t4, -2147483648  #gai tri can tim
    li   $t3, 1

lon_nhi:
    lw   $t1, 0($t0)     #gia tri dc xet
    add  $t0, $t0, 4
    addi $t3, $t3, 1
    beq  $t1, $t2, boqua   # t2 chua gia tri lon nhat // neu ma t1 = t2 thi bo qua ko xet toi
    slt  $t7, $t4, $t1     # so sanh gia tri can tim voi gai tri dc xet
    beq  $t7, $zero, boquatiep  # neu so sanh ma ko lon hon thi bo qua
    add  $t4, $t1, $0  # cap nhat gia tri lon thu hai
boquatiep:  
boqua: 
    li   $t5, 11
    slt  $t9, $t3, $t5
    bne  $t9, $0, lon_nhi 
    
    #add  $a0, $zero, $t4
    #li   $v0, 1
    #syscall
    
    li	$v0, 	4
    la	$a0, 	output_msg #in Second largest value is
    syscall
    
    add  $a0, $zero, $t4  #in gia tri lon thu hai
    li   $v0, 1
    syscall
    
    li	$v0, 	4
    la	$a0, 	index_msg #in found in index
    syscall
    
    
    la   $t0, arr 
    li   $t3, 0 
loop_index:
    lw   $t1, 0($t0)     #gia tri dc xet
    add  $t0, $t0, 4
    
    
    bne  $t4, $t1, outTT 
    
    add  $a0, $zero, $t3  #in vi tri
    li   $v0, 1
    syscall
    
    addi $a0, $0, ',' 
    li $v0, 11 #in dau cach
    syscall
    
    addi $a0, $0, ' ' 
    li $v0, 11 #in dau cach
    syscall
    
outTT:
    addi $t3, $t3, 1
    li   $t5, 10
    slt  $t9, $t3, $t5
    bne  $t9, $0, loop_index
    



