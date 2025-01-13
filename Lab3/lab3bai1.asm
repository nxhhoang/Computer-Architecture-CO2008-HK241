.data
aa: .asciiz "Please insert a: "
bb: .asciiz "Please insert b: "
cc: .asciiz "Please insert c: "
x_bang: .asciiz "x = "
x1_bang: .asciiz "x1 = "
x2_bang: .asciiz "x2 = "
vo_so_nghime: .asciiz "There are an infinite number of solutions\n"
vo_nghime: "There is no real solution"

a: .float 0.0
b: .float 0.0
c: .float 0.0

.text
main:

    li $v0, 4
    la $a0, aa
    syscall
    li $v0, 6
    syscall
    swc1 $f0, a
    
    li $v0, 4
    la $a0, bb
    syscall
    li $v0, 6
    syscall
    swc1 $f0, b
    
    li $v0, 4
    la $a0, cc
    syscall
    li $v0, 6
    syscall
    swc1 $f0, c

# XET A == 0	
	lwc1 $f0, a
	li $t0, 0              # Load 0 into integer register $t0
    mtc1 $t0, $f1          # Move the integer 0 into floating-point register $f1
    c.eq.s $f0, $f1            # So sánh $f0 v?i 0.0
    bc1t is_zero               # Nh?y ??n `is_zero` n?u $f0 == 0.0
# A khac 0

# Tinh delta
    lwc1 $f2, b
    lwc1 $f3, c
    
    mul.s $f4, $f2, $f2 # tinh b*b
    mul.s $f5, $f3, $f0 # tinh a * c
    add.s $f5, $f5, $f5 # 2ac
    add.s $f5, $f5, $f5 # 4ac
    sub.s $f4, $f4, $f5 # delta nek
    
    li $t0, 0              # Load 0 into integer register $t0
	mtc1 $t0, $f1          # Move the integer 0 into floating-point register $f1
    c.eq.s $f4, $f1            # So sánh $f0 v?i 0.0
    bc1t delta_0               # Nh?y ??n `is_zero` n?u $f0 == 0.0

	c.lt.s $f4, $f1           # Compare if $f4 < 0.0
    bc1t  noSolution      # Branch to `less_than_zero` if $f4 is less than 0.0

	sqrt.s $f4, $f4       # CAN BAC HAI CUA DELTA
	sub.s $f2, $f1, $f2    # TINH - B
	add.s $f0, $f0, $f0    # TINH 2 * a
	mov.s $f9, $f4         # LUU TAM CAI CAN BAC 2 CUA DELTA
# x1	
	add.s $f3, $f2, $f4
	
	div.s $f3, $f3, $f0    # Tinh - b + sqrt(delta) / 2a
	
	li $t0, 10000                 # Load 10000 into integer register $t0
	mtc1 $t0, $f5                 # Move 10000 into floating-point register $f5
	cvt.s.w $f5, $f5
	mul.s $f4, $f3, $f5           # $f4 = $f4 * 10000.0
	round.w.s $f6, $f4            # Round $f4 to the nearest integer, result in $f6 as an integer in float format
	cvt.s.w $f7, $f6              # Convert $f6 back to float, store in $f7
	div.s $f8, $f7, $f5           # $f8 = $f7 / 10000.0, result is rounded to 4 decimal places
	
	li $v0, 4
    la $a0, x1_bang
    syscall
    
    mov.s $f12, $f8 # Move contents of register $f3 to register $f12
    li $v0, 2 # Print float number
    syscall
    
    addi $a0, $0, '\n' # Display character ’A’
    li $v0, 11 # print char
    syscall
# x2 
    mov.s $f4, $f9      # TRA GIA TRI CAN BAC 2 CHO DELTA
    sub.s $f3, $f2, $f4
	
	div.s $f3, $f3, $f0    # Tinh - b - sqrt(delta) / 2a
	
	li $t0, 10000                 # Load 10000 into integer register $t0    ################
	mtc1 $t0, $f5                 # Move 10000 into floating-point register $f5   ###############
	cvt.s.w $f5, $f5               ##############
	mul.s $f4, $f3, $f5           # $f4 = $f4 * 10000.0
	round.w.s $f6, $f4            # Round $f4 to the nearest integer, result in $f6 as an integer in float format
	cvt.s.w $f7, $f6              # Convert $f6 back to float, store in $f7
	div.s $f8, $f7, $f5           # $f8 = $f7 / 10000.0, result is rounded to 4 decimal places
	
	li $v0, 4
    la $a0, x2_bang
    syscall
    
    mov.s $f12, $f8 # Move contents of register $f3 to register $f12
    li $v0, 2 # Print float number
    syscall
    j end

# Delta = 0
delta_0:
	li $t0, 0              # Load 0 into integer register $t0
	mtc1 $t0, $f1          # Move the integer 0 into floating-point register $f1
	sub.s $f2, $f1, $f2    # TINH - B
	add.s $f0, $f0, $f0    # TINH 2 * a
	div.s $f2, $f2, $f0    # Tinh - b / 2a
	
    li $t0, 10000                 # Load 10000 into integer register $t0
	mtc1 $t0, $f5                 # Move 10000 into floating-point register $f5
	cvt.s.w $f5, $f5
	mul.s $f4, $f2, $f5           # $f4 = $f4 * 10000.0
	round.w.s $f6, $f4            # Round $f4 to the nearest integer, result in $f6 as an integer in float format
	cvt.s.w $f7, $f6              # Convert $f6 back to float, store in $f7
	div.s $f8, $f7, $f5           # $f8 = $f7 / 10000.0, result is rounded to 4 decimal places
    
    li $v0, 4
    la $a0, x_bang
    syscall
    
    mov.s $f12, $f8 # Move contents of register $f3 to register $f12
    li $v0, 2 # Print float number
    syscall
    j end
	
# A = 0
is_zero:

################## XET B == 0   
    lwc1 $f2, b
    li $t0, 0              # Load 0 into integer register $t0
	mtc1 $t0, $f1          # Move the integer 0 into floating-point register $f1
    c.eq.s $f2, $f1
    bc1t b_bang_0
    
# LAY C de tinh B
    lwc1 $f3, c
    sub.s $f3, $f1, $f3
    div.s $f3, $f3, $f2
    
    li $v0, 4
    la $a0, x_bang
    syscall
    
    mov.s $f12, $f3 # Move contents of register $f3 to register $f12
    li $v0, 2 # Print float number
    syscall
    j end

# NEU A = 0, B = 0
b_bang_0:
    lwc1 $f3, c
    li $t0, 0              # Load 0 into integer register $t0
    mtc1 $t0, $f1          # Move the integer 0 into floating-point register $f1
    c.eq.s $f3, $f1
    bc1t c_bang_0

noSolution:   
    li $v0, 4
    la $a0, vo_nghime
    syscall
    j end
    
c_bang_0:
    li $v0, 4
    la $a0, vo_so_nghime
    syscall
    
end:
    li $v0, 10                 # Syscall code cho thoát ch??ng trình
    syscall
