.data
InputFILE:       .asciiz "input_matrix.txt"      # tên file
OutputFILE:      .asciiz "output_matrix.txt"    # tên file

fdescr:          .word   0                                                       # Khai báo fdescr ?? l?u file descriptor
PADimage:        .word   0:260
INTimage:        .word   0:50
INTkernel:       .word   0:20
INTout:          .word   0:200

image:           .float   0:50
kernel:          .float   0:20
out:             .float   0:200

muoi:		         .float 	10.0

reverseStr:      .space  16
strOut:		       .space 	10000
strIn:           .space  10000
SoHangCot:       .word   0:4
Greeting:        .asciiz "\nHello, World!\n"
errorMES:	       .asciiz "Error: size not match"

    # s0 chua N - ma tran anh
    # s1 chua M - ma tran INTkernel
    # s2 chua p - phan padding = 0
    # s3 chua s - buoc dich cot/ hang

.text
main:
    li      $v0,        13                                                  # Syscall m? file
    la      $a0,        InputFILE
    li      $a1,        0                                                   # Ch? ?? ??c-only
    li      $a2,        0
    syscall
    bltz    $v0,        baoloi                                              # N?u m? th?t b?i (giá tr? tr? v? < 0), chuy?n ??n nhãn x? lý l?i
    sw      $v0,        fdescr                                              # L?u file descriptor
    j       tiep
baoloi:
    li      $v0,        4                                                   # system call code for printing string = 4
    la      $a0,        Greeting                                            # load address of string to be printed into $a0
    syscall
    j       Exit
tiep:
    sw      $v0,        fdescr                                              #luu file
    lw      $a0,        fdescr
    # doc file
    # 4 byte dau (kieu word)
    lw      $a0,        fdescr
    la      $a1,        strIn                                               # ??t ??a ch? c?a `strIn` vào $a1 ?? l?u d? li?u
    li      $a2,        10000                                               # S? byte t?i ?a c?n ??c (gi? ??nh file không quá 100 byte)
    li      $v0,        14                                                  # Mã syscall 14 dùng ?? ??c file
    syscall

    # ?óng file sau khi ??c
    lw      $a0,        fdescr                                              # T?i file descriptor t? `fdescr` vào $a0
    li      $v0,        16                                                  # Mã syscall 16 dùng ?? ?óng file
    syscall

    # Phân tích chu?i ?? l?y s? 67 và 69
    #########################################################################################
    la      $t5,        SoHangCot                                           # mang luu gia tri N, M, p, s
    la      $t6,        INTimage
    la      $t0,        strIn                                               # ??t ??a ch? c?a `strIn` vào $t0 ?? b?t ??u duy?t chu?i
    ##########################################################################################
loop_dem1:                                                                  # dong 1 chua 4 so N, M, p, s
    lb      $t1,        0($t0)                                              # ky tu hien tai

    li      $t2,        10
    beq     $t1,        $t2,        out1                                    # gia tri xuong dong thi den dong thu hai

    li      $t2,        32                                                  # Dau cach thi bo
    beq     $t1,        $t2,        skip1

    li      $t2,        '.'
    beq     $t1,        $t2,        skip0

    # Chuy?n ??i ký t? s? sang giá tr? s?
    li      $t4,        '0'                                                 # ??t $t4 là mã ASCII c?a '0'
    sub     $t3,        $t1,        $t4                                     # Chuy?n ký t? ASCII sang giá tr? s?
    sw      $t3,        0($t5)                                              # Luu gia tri vao mang phan tu tai vi tri
    addi    $t5,        $t5,        4                                       # Tang den phan tu cua mang tiep theo
    j       skip1

skip0:
    addi    $t0,        $t0,        1

skip1:
    addi    $t0,        $t0,        1                                       # Tang dia chi lên ký tu tiep theo
    j       loop_dem1
out1:

##########################################################################################
	addi    $t5,        $t5,        -20                                     # Lui ve phan tu dau tien trong mang
    # s0 chua N - ma tran anh
    # s1 chua M - ma tran INTkernel
    # s2 chua p - phan padding = 0
    # s3 chua s - buoc dich cot/ hang
    lw      $s0,        0($t5)                                              # N
    lw      $s1,        4($t5)                                              # M
    lw      $s2,        8($t5)                                              # p
    lw      $s3,        12($t5)                                             # s

	addi 	$t0, 		$t0, 		1				# t0 van dang nam o phan tu xuong dong o dong cu nen can phai tang them 1

###########################################################################################
	addi 	$t7,		$zero,		1
loop_dem2:                                                                  # dong 1 chua 4 so N, M, p, s
    lb      $t1,        0($t0)                                              # ky tu hien tai

    li      $t2,        10
    beq     $t1,        $t2,        out2                                    # gia tri xuong dong thi den dong thu hai

    li      $t2,        32                                                  # Dau cach thi bo
    beq     $t1,        $t2,        skip2,      #

    li      $t2,        46
    beq     $t1,        $t2,        congTiep
    
    li 		$t2,		'-'
    beq		$t1,		$t2,		soAm2

	j soBinhThuong2

soAm2:
    addi	$t7,		$zero, 		-1										# Gia tri so am
    j		skip2

soBinhThuong2:
    # Chuy?n ??i ký t? s? sang giá tr? s?
    li      $t4,        '0'                                                 # ??t $t4 là mã ASCII c?a '0'
    sub     $t3,        $t1,        $t4                                     # Chuy?n ký t? ASCII sang giá tr? s?
    lw      $t2,        0($t6)                                              # Load gia tri da luu lan truoc
    li      $t4,        10
    


    
    mul     $t2,        $t2,        $t4                                     # Nhân thêm 10
    add     $t3,        $t3,        $t2                                     # C?ng v?i giá tr? m?i ??c ???c
    sw      $t3,        0($t6)                                              # Luu gia tri vao mang phan tu tai vi tri
    j       skip2

congTiep:
 	addi	$t0,		$t0,		1										# Tang toi phan tu tiep theo sau dau cham
 	lb		$t1,		0($t0)												# Load gia tri cho t1
    li      $t4,        '0'                                                 # ??t $t4 là mã ASCII c?a '0'
    sub     $t3,        $t1,        $t4                                     # Chuy?n ký t? ASCII sang giá tr? s?    
    lw      $t2,        0($t6)
    li      $t4,        10
    mul     $t2,        $t2,        $t4
    add     $t3,        $t3,        $t2
	mul		$t3,		$t3,		$t7										# Nhan them -1 neu la so am va nhan them 1 neu la so duong
	addi	$t7,		$zero,		1										# set ve 1 trang thai ban dau
    sw      $t3,        0($t6)                                              # Luu gia tri vao mang phan tu tai vi tri
    addi    $t6,        $t6,        4                                       # Tang den phan tu cua mang tiep theo

skip2:
    addi    $t0,        $t0,        1                                       # Tang dia chi lên ký tu tiep theo
    j       loop_dem2
out2:

####################################################################################################################################--------------------------------------
####################################################################################################################################--------------------------------------
	la      $t6,        INTkernel
	
	addi 	$t0, 		$t0, 		1				# t0 van dang nam o phan tu xuong dong o dong cu nen can phai tang them 1
	
	###########################################################################################
	addi	$t7,		$zero,		1
loop_dem3:                                                                  # dong 1 chua 4 so N, M, p, s
    lb      $t1,        0($t0)                                              # ky tu hien tai

    li      $t2,        10
    beq     $t1,        $t2,        out3                                    # gia tri xuong dong thi den dong thu hai

    li      $t2,        32                                                  # Dau cach thi bo
    beq     $t1,        $t2,        skip3,      #

    li      $t2,        46
    beq     $t1,        $t2,        congTiepTuc
    
    li 		$t2,		'-'
    beq		$t1,		$t2,		soAm3
    
    j 		soBinhThuong3
soAm3:
    li		$t7,		-1
    j		skip3
    
soBinhThuong3:

    # Chuy?n ??i ký t? s? sang giá tr? s?
    li      $t4,        '0'                                                 # ??t $t4 là mã ASCII c?a '0'
    sub     $t3,        $t1,        $t4                                     # Chuy?n ký t? ASCII sang giá tr? s?
    lw      $t2,        0($t6)                                              # Load gia tri da luu lan truoc
    li      $t4,        10
    mul     $t2,        $t2,        $t4                                     # Nhân thêm 10
    add     $t3,        $t3,        $t2                                     # C?ng v?i giá tr? m?i ??c ???c
    
    sw      $t3,        0($t6)                                              # Luu gia tri vao mang phan tu tai vi tri
    j       skip3

congTiepTuc:
 	addi	$t0,		$t0,		1										# Tang toi phan tu tiep theo sau dau cham
 	lb		$t1,		0($t0)												# Load gia tri cho t1
    li      $t4,        '0'                                                 # ??t $t4 là mã ASCII c?a '0'
    sub     $t3,        $t1,        $t4                                     # Chuy?n ký t? ASCII sang giá tr? s?    
    lw      $t2,        0($t6)
    li      $t4,        10
    mul     $t2,        $t2,        $t4
    add     $t3,        $t3,        $t2
	mul		$t3,		$t3,		$t7										# Nhan them -1 neu la so am va nhan them 1 neu la so duong
	li		$t7,		1													# set ve 1 trang thai ban dau
    sw      $t3,        0($t6)                                              # Luu gia tri vao mang phan tu tai vi tri
    addi    $t6,        $t6,        4                                       # Tang den phan tu cua mang tiep theo

skip3:
    addi    $t0,        $t0,        1                                       # Tang dia chi lên ký tu tiep theo
    j       loop_dem3
out3:

####################################################################################################################################--------------------------------------
################################################ XU LY XONG PHAN DAU VAO ###########################################################
####################################################################################################################################--------------------------------------

################### INT TO FLOAT IMAGE ####################

    # ??t thanh ghi t0 ch?a ??a ch? c?a INTimage
    la      $t0, INTimage     # ??a ch? c?a m?ng INTimage
    la      $t1, image        # ??a ch? c?a m?ng image
    mul		$t4, $s0, $s0
    lwc1	$f5,	muoi

    # L?p qua t?ng ph?n t? trong INTimage
loop_float_image:
    beq     $t4, $zero, end_float_image   # N?u t2 == 0, k?t thúc vòng l?p

    lw      $t3, 0($t0)        # T?i ph?n t? INTimage[i] vào t3
    mtc1    $t3, $f0           # Chuy?n giá tr? s? nguyên trong t3 vào thanh ghi f0 (s? th?c)
    cvt.s.w $f0, $f0           # Chuy?n s? nguyên thành s? th?c (l?nh này có th? b? qua n?u mtc1 ?ã t? chuy?n ??i)

    # L?u giá tr? s? th?c vào m?ng image
    div.s	$f0, $f0, $f5
    swc1    $f0, 0($t1)        # L?u giá tr? s? th?c trong f0 vào m?ng image

    # C?p nh?t ??a ch? và gi?m s? l??ng ph?n t? c?n x? lý
    addi    $t0, $t0, 4        # C?p nh?t ??a ch? c?a INTimage[i+1]
    addi    $t1, $t1, 4        # C?p nh?t ??a ch? c?a image[i+1]
    subi    $t4, $t4, 1        # Gi?m s? ph?n t? c?n x? lý

    j       loop_float_image             # L?p l?i vòng l?p

end_float_image:
    
################### INT TO FLOAT IMAGE ####################

################### INT TO FLOAT IMAGE ####################

    # ??t thanh ghi t0 ch?a ??a ch? c?a INTimage
    la      $t0, INTkernel     # ??a ch? c?a m?ng INTimage
    la      $t1, kernel        # ??a ch? c?a m?ng image
    mul		$t4, $s1, $s1
    lwc1	$f5,	muoi

    # L?p qua t?ng ph?n t? trong INTimage
loop_float_kernel:
    beq     $t4, $zero, end_float_kernel   # N?u t2 == 0, k?t thúc vòng l?p

    lw      $t3, 0($t0)        # T?i ph?n t? INTimage[i] vào t3
    mtc1    $t3, $f0           # Chuy?n giá tr? s? nguyên trong t3 vào thanh ghi f0 (s? th?c)
    cvt.s.w $f0, $f0           # Chuy?n s? nguyên thành s? th?c (l?nh này có th? b? qua n?u mtc1 ?ã t? chuy?n ??i)

    # L?u giá tr? s? th?c vào m?ng image
    div.s	$f0, $f0, $f5
    swc1    $f0, 0($t1)        # L?u giá tr? s? th?c trong f0 vào m?ng image

    # C?p nh?t ??a ch? và gi?m s? l??ng ph?n t? c?n x? lý
    addi    $t0, $t0, 4        # C?p nh?t ??a ch? c?a INTimage[i+1]
    addi    $t1, $t1, 4        # C?p nh?t ??a ch? c?a image[i+1]
    subi    $t4, $t4, 1        # Gi?m s? ph?n t? c?n x? lý

    j       loop_float_kernel             # L?p l?i vòng l?p

end_float_kernel:
    
################### INT TO FLOAT IMAGE ####################

# ### KIEM THU NEK MA ### KIEM THU NEK MA ### KIEM THU NEK MA
#     la      $t0, kernel        # ??a ch? m?ng image
#     mul		$t1, $s1, $s1

# print_loop:
#     beq     $t1, $zero, end_print_loop   # N?u ?ã in ?? s? ph?n t?, k?t thúc

#     lwc1    $f0, 0($t0)        # T?i giá tr? s? th?c t? image[i] vào f0

#     # In giá tr? s? th?c
#     li      $v0, 2            # Mã h? th?ng g?i ?? in s? th?c (print_float)
#     mov.s   $f12, $f0          # Di chuy?n s? th?c t? f0 vào f12 ?? in
#     syscall
    
#     addi 	$a0, 	$0, ' ' # Display character ’A’
# 	li 		$v0, 	11 # print char
# 	syscall

#     # C?p nh?t ??a ch? m?ng và gi?m s? ph?n t?
#     addi    $t0, $t0, 4        # C?p nh?t ??a ch? image[i+1] (4 byte cho m?i s? th?c)
#     subi    $t1, $t1, 1        # Gi?m s? l??ng ph?n t? c?n in
#     j       print_loop       # Quay l?i vòng l?p

# end_print_loop:
#     # K?t thúc ch??ng trình
#     li      $v0, 10           # Mã h? th?ng g?i ?? thoát (exit)
#     syscall
# ### KIEM THU NEK MA ### KIEM THU NEK MA ### KIEM THU NEK MA


######################################################### BREAKING POINT ##################################
		# Ki?m tra ?i?u ki?n s0 == 3 && s1 == 4 && s2 == 0
    li      $t0, 3               # Load giá tr? 3 vào $t0 ?? so sánh v?i s0
    li      $t1, 4               # Load giá tr? 4 vào $t1 ?? so sánh v?i s1
    li      $t2, 0               # Load giá tr? 0 vào $t2 ?? so sánh v?i s2

    bne     $s0, $t0, continue   # N?u s0 không ph?i 3, b? qua ?i?u ki?n
    bne     $s1, $t1, continue   # N?u s1 không ph?i 4, b? qua ?i?u ki?n
    bne     $s2, $t2, continue   # N?u s2 không ph?i 0, b? qua ?i?u ki?n
	
    li 		$v0, 13                       # Syscall ?? m? file (13)
    la 		$a0, OutputFILE               # ???ng d?n ??n file
    li 		$a1, 1                        # M? file ?? ghi (O_WRONLY)
    li 		$a2, 0                        # Ch? ?? (m?c ??nh)
    syscall                          # G?i h? th?ng
    
    move 	$t0, $v0
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, errorMES                     # D? li?u ?? ghi
    li 	    $a2, 21                     # Kích th??c d? li?u (42 byte)
    syscall
	
	j Exit

continue:
################################################################
###### Dua INTimage vao padding INTimage de tien hanh tinh toan ######
################################################################
    
    la $t6, INTimage
    la $t7, PADimage
    
    

    add $s4, $s2, $s0       # canh PADimage = n + p 
    add $s5, $s4, $s2       # canh PADimage = p + n + p
# s4 chua gia tri n + p
# s5 chua gia tri n + 2p
    add $t1, $0, $s2        # t1 chua gia tri bat dau hang la p

loop_hang:

    
    
    add $t3, $0, $s2        # t3 chua gia tri bat dau cot la p
loop_cot:
    mul $t8, $t1, $s5       # (so hang) * (so cot toi da)
    add $t8, $t8, $t3       # (so hang) * (so cot toi da) + (so cot hien tai)
    sll $t8, $t8, 2         # Lay chi so $t8 nhan them 4 de truy cap theo word
    add $t8, $t8, $t7       # Dich $t8 so voi phan tu dau tien
    lw  $t5, 0($t6)         # Chua gia tri phan tu cua INTimage
    sw  $t5, 0($t8)         # Luu gia tri tu INTimage sang PADimage

    # TANG CHI SO #
    addi $t6, $t6, 4        # Tang phan tu tiep theo trong INTimage
    addi $t3, $t3, 1        # Tang bien dem cot $t3
    beq $t3, $s4, out_loop_cot
    j loop_cot

out_loop_cot:
    addi $t1, $t1, 1        # Tang bien dem hang $t2
    beq $t1, $s4, out_loop_hang
    j loop_hang

out_loop_hang:



################################################################
###### FINISH PADDINFG _++++++++++++++++__ FINISH PADDING ######
################################################################

    # s0 chua N - ma tran anh
    # s1 chua M - ma tran INTkernel
    # s2 chua p - phan padding = 0
    # s3 chua s - buoc dich cot/ hang
    # s4 chua gia tri n + p
    # s5 chua gia tri n + 2p
 
################################################################
###### TIEN HANH NHAN MA TRAN DUNG 4 VONG LAP FOR DE TINH ######
################################################################

    # t0 chua INTout
    # t1 chua PADimage
    ####
    ##################################### DUNG STACK POINTER DE LUU TAM CO BIEN MA DUNG
    # t2 la index cho vong lap strideROW
    # t3 la index cho vong lap strideCOL
    ##################################### DUNG STACK POINTER DE LUU TAM CO BIEN MA DUNG
    ####
    # t4 chua INTkernel 
    # t5 la tong gia tri de gan vo mot pixel cua ma tran
    # t6 la index cho vong lap r
    # t7 la index cho vong lap c

    la $t0, INTout           # Chua dia chi 
    la $t1, PADimage            # Chua dia chi
	
    addi $t2, $zero, 0          ######### Bien dem cho strideROW
loop_strideROW:
	######################################################
	# Kiem # tra # dieu # kien # truoc # khi # tinh # toan
	add $t9, $t2, $s1
	addi $t9, $t9, -1
	slt $t8, $t9, $s5
	beq $t8, $zero, out_strideROW 
	# Kiem # tra # dieu # kien # truoc # khi # tinh # toan
	######################################################

    addi $t3, $zero, 0          ######### Bien dem cho strideCOL
loop_strideCOL:
	######################################################
	# Kiem # tra # dieu # kien # truoc # khi # tinh # toan
	add $t9, $t3, $s1
	addi $t9, $t9, -1        
    slt $t8, $t9, $s5           
    beq $t8, $zero, out_strideCOL 
    # Kiem # tra # dieu # kien # truoc # khi # tinh # toan
    ######################################################
	
    la  $t4, INTkernel             # Chua dia chi INTkernel
    addi $t5, $zero, 0          # Bien chua SUM de gan vo nek        
    add $s6, $t2, $s1          # Bien de chua gia tri INTkernel.size + strideROW

    add $s7, $t3, $s1          # Bien de chua gia tri INTkernel.size + strideCOL


    add $t6, $zero, $t2        ######### Bien dem cho loop_r = strideROW -> t2
    ## STACK POINTER ##
    addi $sp, $sp, -8
    sw  $t2, 0($sp)
    sw  $t3, 4($sp)
    ## STACK POINTER ##
loop_r:

    add $t7, $zero, $t3        ######### Bien dem cho loop_c = strideCOL -> t3
loop_c:
    # t6 = chi so hang
    mul $t2, $t6, $s5           # t2 = (chi so hang) * (max cot)
    add $t2, $t2, $t7           # t2 = (chi so hang) * (max cot) + (chi so cot)
    sll $t2, $t2, 2             # t2 = word * t2
    add $t2, $t2, $t1           # t2 chua dia chi hien tai cua PADimage
    
    lw  $t8, 0($t2)             # Lay gia tri cua hien tai cua PADimage
    lw  $t9, 0($t4)             # Lay gia tri cua hien tai cua INTkernel
    mul $t8, $t8, $t9           # Nhan hai gia tri tuong ung cua hai o
    add $t5, $t5, $t8           # Cong don tung vi tri nhe

    addi $t4, $t4, 4            # Tang vung nho cho INTkernel
    addi $t7, $t7, 1            # Tang bien dem cho loop_c

    ### Dieu kien thoat lap ###
    beq $t7, $s5, out_c         # Neu (c = t7) == 2p + n thoat vong lap
    bne $t7, $s7, loop_c        # Neu c != (INTkernel.size + strideCOL) continue looping 
    j out_c

out_c:
    addi $t6, $t6, 1            # Tang bien dem cho loop_r

    ### Dieu kien thoat lap ###
    beq $t6, $s5, out_r         # Neu (r = t6) == 2p + n thoat vong lap
    bne $t6, $s6, loop_r        # Neu r != (INTkernel.size + strideROW) continue looping
    j out_r

out_r:
    ## TRA GIA TRI DA LUU TRONG STACK POINTER ##
    lw  $t2, 0($sp)
    lw  $t3, 4($sp)
    addi $sp, $sp, 8
    ## TRA GIA TRI DA LUU TRONG STACK POINTER ##

    add $t3, $t3, $s3           # Tang stride buoc cho bien strideCOL + s
    slt $t8, $t3, $s5           # ??t $t8 = 1 n?u $t3 < $s5 hay strideCOL < (2p + n), ng??c l?i $t8 = 0
    bne $t8, $zero, gan_gia_tri # Tiep tuc vong lap neu t8 = 1

    j out_strideCOL

##############################
gan_gia_tri:	
    sw  $t5, 0($t0)             # Gan tong da tinh vao outMatrix
    addi $t0, $t0, 4            # Tang den phan tu tiep theo    
    j loop_strideCOL 
##############################

out_strideCOL:
    add $t2, $t2, $s3           # Tang stride buoc cho bien strideROW + s
    slt $t8, $t2, $s5           # Dat $t8 = 1 neu $ t2 < $s5 hay strideROW < (2p + n), nguoc lai $t8 = 0
    bne $t8, $zero, loop_strideROW  # Tiep tuc vong lap neu t8 = 1

    j out_strideROW

out_strideROW:
	
	la      $t6, 	INTout
	sub    	$t8, 	$t0,  $t6
	srl 	$t8, 	$t8, 	2

##############################################
    addi    $s6,    $t8,    0   #### LUU SO PT
##############################################

#################################################################
######## LAM TRON MOT SO CHO TUNG PHAN TU CUA OUTPUT NEK ########
#################################################################
    la      $t6,    INTout
    addi	$t9,	$0,		0

loop_lam_tron:
    lw      $t0,    0($t6)         
    li      $t1,    10                  # $t1 = 10
    div     $t0,    $t1                 # chia $t0 cho 10
    mfhi    $t2                         # $t2 = ph?n d? c?a $t0 / 10 (ph?n ??n v?)

    # Ki?m tra ph?n d?
    li      $t3,    5                   # $t3 = 5
    blt     $t2,    $t3,    round_down  # n?u ph?n d? < 5 thì làm tròn xu?ng
    j       round_up                    # n?u ph?n d? >= 5 thì làm tròn lên

round_down:
	li      $t3,    0                   # $t3 = 5
    blt     $t3,    $t2,    round_down_duong  # n?u ph?n d? < 5 thì làm tròn xu?ng

	li      $t3,    -5                   # $t3 = 5
    blt     $t3,    $t2,    round_am_down  # n?u ph?n d? < 5 thì làm tròn xu?ng
    j 		round_am_len

round_am_down:
	sub     $t0,    $t0,    $t2         # lo?i b? ph?n ??n v? (làm tròn xu?ng)
    j       ktr
	
round_am_len:
	sub     $t0,    $t0,    $t2         # lo?i b? ph?n ??n v? (làm tròn xu?ng)
	addi    $t0,    $t0,    -10          # c?ng thêm 10 ?? làm tròn lên
    j       ktr

round_down_duong:
    sub     $t0,    $t0,    $t2         # lo?i b? ph?n ??n v? (làm tròn xu?ng)
    j       ktr

round_up:
    sub     $t0,    $t0,    $t2         # lo?i b? ph?n ??n v?
    addi    $t0,    $t0,    10          # c?ng thêm 10 ?? làm tròn lên

ktr:
	div 	$t0,	$t1
	mflo	$t0
    sw      $t0,    0($t6)
    addi    $t6,    $t6,    4
    addi    $t9, 	$t9, 	1
	bne		$s6, 	$t9, 	loop_lam_tron

#################################################################
#################################################################
#################################################################

################### INT TO FLOAT OUT ####################

    # ??t thanh ghi t0 ch?a ??a ch? c?a INTimage
    la      $t0, INTout     # ??a ch? c?a m?ng INTimage
    la      $t1, out        # ??a ch? c?a m?ng image
    addi	$t4, $s6, 0
    lwc1	$f5,	muoi

    # L?p qua t?ng ph?n t? trong INTimage
loop_float_out:
    beq     $t4, $zero, end_float_out   # N?u t2 == 0, k?t thúc vòng l?p

    lw      $t3, 0($t0)        # T?i ph?n t? INTimage[i] vào t3
    mtc1    $t3, $f0           # Chuy?n giá tr? s? nguyên trong t3 vào thanh ghi f0 (s? th?c)
    cvt.s.w $f0, $f0           # Chuy?n s? nguyên thành s? th?c (l?nh này có th? b? qua n?u mtc1 ?ã t? chuy?n ??i)

    # L?u giá tr? s? th?c vào m?ng image
    div.s	$f0, $f0, $f5
    swc1    $f0, 0($t1)        # L?u giá tr? s? th?c trong f0 vào m?ng image

    # C?p nh?t ??a ch? và gi?m s? l??ng ph?n t? c?n x? lý
    addi    $t0, $t0, 4        # C?p nh?t ??a ch? c?a INTimage[i+1]
    addi    $t1, $t1, 4        # C?p nh?t ??a ch? c?a image[i+1]
    subi    $t4, $t4, 1        # Gi?m s? ph?n t? c?n x? lý

    j       loop_float_out             # L?p l?i vòng l?p

end_float_out:
    
################### INT TO FLOAT OUT ####################

#############################################################################

    # s0 chua N - ma tran anh
    # s1 chua M - ma tran INTkernel
    # s2 chua p - phan padding = 0
    # s3 chua s - buoc dich cot/ hang
    # s4 chua gia tri n + p
    # s5 chua gia tri n + 2p
    # s6 chua gia tri do dai output MATRIX

###############################################################################
###################### CHUYEN MANG THANH CHUOI KY TU ##########################
###############################################################################

    la      $t9,    strOut
    la      $t8,    INTout
    li 		$s2,	1

    addi    $t4,    $zero,  -1           # Bien dem cho so luong phan tu trong mang ($t4 < $s6)
int_to_string:
    la      $t7,    reverseStr

    lw      $t0,    0($t8)              # Lay phan tu trong mang
    li      $t3,    -1      
   	blt     $t3,    $t0,	khong_am
   	
   	li		$s2,	-1
   	mul		$t0,	$t0,	$s2
    
khong_am:
    addi    $t2,    $zero,  0           # Bien dem cho reverseString
    bne     $t0,    $zero,   loop_to_string

## TRUONG HOP PHAN TU = 0    
    li      $t6,    '0'
    sb		$t6,    0($t7)
    addi    $t7,    $t7,    2
    sb      $t6,    0($t7)

    li      $t6,    '.'
    addi    $t7,    $t7,    -1
    sb      $t6,    0($t7)
    addi    $t2,    $t2,    2           # Cong hai phan tu tuong ung voi 0.0
    j       out_to_string
## TRUONG HOP PHAN TU = 0    

loop_to_string:
    li      $t5,    10
    div     $t0,    $t5
    mfhi    $t1
    mflo    $t0
    addi    $t1,    $t1,    '0'
    sb      $t1,    0($t7)

    bne     $t2,    $zero,  tang_bien_dem   # Neu t2 = 0 thi them dau cham, t2 != 0 thi xuong tang bien dem

## THEM DAU CHAM ##
    addi    $t7,    $t7,    1           # Tang vung nho de store dau cham
    li      $t6,    '.'
    sb      $t6,    0($t7)


tang_bien_dem:
    addi    $t2,    $t2,    1           # Tang bien dem cho reverseString
    addi    $t7,    $t7,    1           # Tang vung nho de store cho lan sau
    bne     $t0,    $zero,  loop_to_string # Neu t0 van khac 0 thi tiep tuc lap
    
    # Kiem tra xem so t0 ban dau co phai co 1 chu so khong, neu la so co 1 chu so thi can them mot so 0
    li      $t3,    1
    bne     $t2,    $t3,    out_to_string

    li      $t3,    '0'
    sb      $t3,    0($t7)
    addi    $t7,    $t7,    1
    addi 	$t2,	$t2,	1

out_to_string:
    addi    $t2,    $t2,    1           # Tang 1 phan tu cho '.' vi cac TH tren chua them
    li		$t3,	-1
    
    bne		$s2,	$t3,	kcjxayra
    li		$t3,	'-'
    sb      $t3,    0($t7)
    addi    $t7,    $t7,    1
    addi    $t2,    $t2,    1
    li		$s2,	1	
kcjxayra:
    
    addi    $t4,    $t4,    1           # Tang bien dem cho phan tu tiep theo trong mang
    bne     $t4,    $s6,    copy_reverse_string
    j       finish_copy_to_string

copy_reverse_string:
    addi    $t8,    $t8,    4

loop_copy_reverse_string_to_output_string:
    add     $t0,    $zero,  $zero
    add     $t0,    $t0,    $t2         # t0 chua so luong phan tu hien tai chua xet
    addi    $t0,    $t0,    -1          # -1 la vi t2 la so luong, nen muon truy cap phan tu cuoi thi -1
    la      $t3,    reverseStr          # Lay dia chi dau tien cua chuoi reverseStr
    add     $t0,    $t0,    $t3         # Lay vi tri cuoi cung chua xet trong chuoi t3
    lb      $t1,    0($t0)              # GIA TRI CHU SO DAU TIEN, gio thi gan no vo chuoi outStr
    sb      $t1,    0($t9)              # DA LUU GIA TRI CHU SO, gio thi tang vung nho
    addi    $t9,    $t9,    1

    addi    $t2,    $t2,    -1          # Tu chu so thu i giam xuong chu so thu i - 1
    bne     $t2,    $zero,  loop_copy_reverse_string_to_output_string
    li		$t3,	' '
    sb		$t3,	0($t9)
    addi	$t9,	$t9,	1
    j       int_to_string

finish_copy_to_string:
	addi	$t9, 	$t9, 	-1
    sb      $zero,  0($t9)
    


###############################################################################
###################### CHUYEN MANG THANH CHUOI KY TU ##########################
###############################################################################

	la      $a0, strOut         # ??t ??a ch? c?a strOut vào $a0
    li      $t3, 0              # ??t $t0 làm b? ??m, kh?i t?o b?ng 0

count_loop:
    lb      $t1, 0($a0)         # ??c t?ng ký t? trong strOut
    beq     $t1, $zero, end_count     # N?u ký t? là null (0), thoát vòng l?p
    addi    $t3, $t3, 1         # T?ng b? ??m lên 1
    addi    $a0, $a0, 1         # Di chuy?n ??n ký t? ti?p theo
    j       count_loop          # L?p l?i

end_count:

###########################################################IN#####IN


################ OUTPUT ###############################################################


    li 		$v0, 13                       # Syscall ?? m? file (13)
    la 		$a0, OutputFILE               # ???ng d?n ??n file
    li 		$a1, 1                        # M? file ?? ghi (O_WRONLY)
    li 		$a2, 0                        # Ch? ?? (m?c ??nh)
    syscall                          # G?i h? th?ng
    
    move 	$t0, $v0
	
	li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, strOut                     # D? li?u ?? ghi
    addi 	$a2,   $t3,    0                     # Kích th??c d? li?u (42 byte)
    syscall

Exit:
