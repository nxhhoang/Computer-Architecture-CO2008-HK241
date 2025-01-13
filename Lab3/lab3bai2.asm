.data
prompt_u: .asciiz "Please insert u: "
prompt_v: .asciiz "Please insert v: "
prompt_a: .asciiz "Please insert a: "
prompt_b: .asciiz "Please insert b: "
prompt_c: .asciiz "Please insert c: "
prompt_d: .asciiz "Please insert d: "
prompt_e: .asciiz "Please insert e: "
result_msg: .asciiz "The result of the integral is: "

# Variables to store input values
var_u: .float 0.0
var_v: .float 0.0
var_a: .float 0.0
var_b: .float 0.0
var_c: .float 0.0
var_d: .float 0.0
var_e: .float 0.0
result: .float 0.0

.text
main:

    li $v0, 4
    la $a0, prompt_u
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_u
    
    li $v0, 4
    la $a0, prompt_v
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_v
    
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_a
    
    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_b
    
    li $v0, 4
    la $a0, prompt_c
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_c
    
    li $v0, 4
    la $a0, prompt_d
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_d
    
    li $v0, 4
    la $a0, prompt_e
    syscall
    li $v0, 6
    syscall
    swc1 $f0, var_e
    
    ############################################
    
    # Tinh d * d * d * d // d la f5
    lwc1 $f5, var_d            # Load d vo $f5
    mul.s $f5, $f5, $f5
    mul.s $f5, $f5, $f5
    
    # Tinh e * e * e // e la f6
    lwc1 $f6, var_e            # Load e vo $f6
    mul.s $f7, $f6, $f6
    mul.s $f6, $f7, $f6
    
    # Tinh mau so d^4 + e^3
    add.s $f5, $f5, $f6
    # f6 va f7 co the dung lai
    
    # Tinh nguyen ham truoc de tru nhau cho de
    
    # Tinh a / 7
    lui $t0, 0x40E0
    addi $sp, $sp, -4
    sw $t0, 0($sp)
    lwc1 $f7, 0($sp)
    lwc1 $f2, var_a
    div.s $f2, $f2, $f7
    
    # Tinh b / 6
    addi $t0, $0, 6      # ??a giá tr? 7 vào thanh ghi $t0
    mtc1 $t0, $f7        # Chuy?n giá tr? t? thanh ghi $t0 vào thanh ghi $f6 (m?t thanh ghi s? th?c)
    cvt.s.w $f7, $f7     # Chuy?n giá tr? trong $f6 t? s? nguyên thành s? th?c (float)
    lwc1 $f3, var_b
    div.s $f3, $f3, $f7  # Chia $f2 cho $f6, k?t qu? l?u vào $f4
    
    # Tinh c / 2
    addi $t0, $0, 2      # ??a giá tr? 7 vào thanh ghi $t0
    mtc1 $t0, $f7        # Chuy?n giá tr? t? thanh ghi $t0 vào thanh ghi $f6 (m?t thanh ghi s? th?c)
    cvt.s.w $f7, $f7     # Chuy?n giá tr? trong $f6 t? s? nguyên thành s? th?c (float)
    lwc1 $f4, var_c
    div.s $f4, $f4, $f7  # Chia $f2 cho $f6, k?t qu? l?u vào $f4
    
# f5 chua d ^ 4 + e ^ 3
# f2 chua a / 7
# f3 chua b / 6
# f4 chua c / 2

# TINH U
    lwc1  $f0, var_u       # u ^ 1
    mul.s $f6, $f0, $f0   # u ^ 2
    mul.s $f7, $f6, $f4   # Nhan c / 2 voi u ^ 2
    
    mul.s $f6, $f6, $f0   # u ^ 3
    mul.s $f6, $f6, $f6   # u ^ 6
    mul.s $f8, $f6, $f3   # Nhan b / 6 voi u ^ 6
    add.s $f7, $f7, $f8
    
    mul.s $f6, $f6, $f0   # u ^ 7
    mul.s $f8, $f6, $f2   # Nhan a / 7 voi u ^ 7
    add.s $f7, $f7, $f8   # a/7 * u^7 + b/6 * u^6 + c/2 * u^2
    add.s $f0, $f7, $f7   # Luu lai vao bien f0
    sub.s $f0, $f0, $f7   # Doan lenh tren va doan lenh nay tuong duong f0 = f7
    
# TINH V
    lwc1  $f1, var_v       # u ^ 1
    mul.s $f6, $f1, $f1   # u ^ 2
    mul.s $f7, $f6, $f4   # Nhan c / 2 voi u ^ 2
    
    mul.s $f6, $f6, $f1   # u ^ 3
    mul.s $f6, $f6, $f6   # u ^ 6
    mul.s $f8, $f6, $f3   # Nhan b / 6 voi u ^ 6
    add.s $f7, $f7, $f8
    
    mul.s $f6, $f6, $f1   # u ^ 7
    mul.s $f8, $f6, $f2   # Nhan a / 7 voi u ^ 7
    add.s $f7, $f7, $f8   # a/7 * u^7 + b/6 * u^6 + c/2 * u^2
    add.s $f1, $f7, $f7   # Luu lai vao bien f0 
    sub.s $f1, $f1, $f7
    
# TINH  U - V
    sub.s $f0, $f0, $f1

# CHIA CHO MAU SO
    div.s $f0, $f0, $f5

	li $t0, 10000                 # Load 10000 into integer register $t0    ################
	mtc1 $t0, $f5                 # Move 10000 into floating-point register $f5   ###############
	cvt.s.w $f5, $f5               ##############
	mul.s $f4, $f0, $f5           # $f4 = $f4 * 10000.0
	round.w.s $f6, $f4            # Round $f4 to the nearest integer, result in $f6 as an integer in float format
	cvt.s.w $f7, $f6              # Convert $f6 back to float, store in $f7
	div.s $f8, $f7, $f5           # $f8 = $f7 / 10000.0, result is rounded to 4 decimal places

    mov.s $f12, $f8 # Move contents of register $f3 to register $f12
    li $v0, 2 # Print float number
    syscall
