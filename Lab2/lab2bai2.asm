
.data
arr:    .space 20
sodu:   .word  0, -1, -2, 1  


    
.text
main:
    li  $t0, 0        # mang arr
    li  $t1, 5        # 5 so can nhap
    li  $t2, 5
    li  $t3, 4
    la  $t9, sodu

input_loop:
    li  $v0, 5 
    syscall
    sw  $v0, arr($t0) #luu gia trij
    
    addi $t0, $t0, 4  #tang diachi

    addi $t1, $t1, -1   #giam
    bne  $t1, $0, input_loop
########################################
    addi $t0, $t0, -20
    
    la   $t8, arr
    
    
DivCheck:
    beq  $t2, $0, Exit
    addi $t2, $t2, -1

    lw   $t4, 0($t8)
    div  $t4, $t3  #chia
    mfhi $t5  #so du
    sll  $t5, $t5, 2 #so du nhan 4 de truy cap mang so du
    add  $t5, $t5, $t9 #dich con tro
    lw   $t6, 0($t5) # load gia tri cua con tro
    add  $t4, $t4, $t6 # cong gia tri thanh so chia 4
    
    add  $a0, $zero, $t4
    li   $v0, 1
    syscall
    
    addi $a0, $0, ' ' 
    li $v0, 11 #in dau cach
    syscall
    
    sw  $t4, 0($t8)
    addi $t8, $t8, 4
    
    j DivCheck
    
Exit:
    li $v0, 10
    syscall
    
