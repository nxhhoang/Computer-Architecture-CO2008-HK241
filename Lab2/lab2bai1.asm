    .data
ascii_table:    .word 0:128  #Mang 128 ptu
strIn: 		.space 200

    .text
main:
    la 	 $a0, strIn        # nhap chuoi vo
    addi $a1, $0, 200
    li	 $v0, 8
    syscall
    
    la   $t5, strIn     # dia chi cua chuoi nhap vao la t5
    la   $t0, ascii_table  # dia chi mang dem
    
loop_dem:
    lb   $t4, 0($t5)    # ky tu hien tai
    beq  $t4, $0, out   # null thi out

    li   $t7, 32        # Dau cach thi bo
    beq  $t4, $t7, skip # 

    li   $t7, 44        # Dau ohay thi bo
    beq  $t4, $t7, skip # 

    sll  $t4, $t4, 2    # dich 4 byte
    
    add  $t1, $t0, $t4  # truy cap phan tu trong mang
    lw   $t6, 0($t1)    # lay gia tri trong mang dem
    addi $t6, $t6, 1    # tang len 1 su hien dien
    sw   $t6, 0($t1)    # tra ve gia tri cho mang dem

skip:
    addi $t5, $t5, 1    # T?ng ??a ch? lên ký t? ti?p theo
    j loop_dem

    
out:

    
    
la   $t0, ascii_table    # ??a ch? c?a m?ng ascii_table trong $t0 
    li   $s0, 1              # Bien dem cho gia tri tu 1 den 200
    li   $s1, 200            # Bien dung
    
loop1:
    
    li   $s2, 12
    li   $s3, 128
loop2:
    sll  $s7, $s2, 2       # tang thanh kich thucc cua word
    add  $t6, $t0, $s7     # tang len dia chi
    lw   $s4, 0($t6)       # lay gia tri cua phan tu trong mang
    bne  $s4, $s0, out1    # neu khong bang nhay ra va khong in
    
    move $a0, $s2          # In gia tri cua s4 ra
    li   $v0, 11           # In ky tu
    syscall
    
    addi $a0, $0, ',' 
    li $v0, 11             #in dau cach
    syscall
    
    addi $a0, $0, ' ' 
    li $v0, 11             #in dau cach
    syscall
    
    add  $a0, $zero, $s4  #in so 
    li   $v0, 1
    syscall
    
    addi $a0, $0, ';' 
    li $v0, 11             #in dau cach
    syscall

out1:
    addi $s2, $s2, 1
    bne  $s2, $s3, loop2

out2:
    addi $s0, $s0, 1
    bne  $s0, $s1, loop1
