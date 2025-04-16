.data
InputFile:   .asciiz "raw_input.txt"    # tên file
OutputFile:  .asciiz "formatted_result.txt"

fdescr:     .word   0                                                       # Khai báo fdescr ?? l?u file descriptor


strIn:      .space  300
Greeting:   .asciiz "\nHello, World!\n"

name: .space 50
mssv: .space 20
diachi: .space 100
age: .space 10
religion: .space 20 

dong1: .asciiz "--Student personal information-- \n" 
dong2: .asciiz "Name: "
dong3: .asciiz "ID: "
dong4: .asciiz "Address: "
dong5: .asciiz "Age: "
dong6: .asciiz "Religion: "
n: .asciiz "\n"


.text
main:
    li      $v0,        13                                                  # Syscall m? file
    la      $a0,        InputFile
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
    li      $a2,        300                                               # S? byte t?i ?a c?n ??c (gi? ??nh file không quá 100 byte)
    li      $v0,        14                                                  # Mã syscall 14 dùng ?? ??c file
    syscall

    # ?óng file sau khi ??c
    lw      $a0,        fdescr                                              # T?i file descriptor t? `fdescr` vào $a0
    li      $v0,        16                                                  # Mã syscall 16 dùng ?? ?óng file
    syscall

  
   ######################## Dia chi ###############################
    la      $t0, strIn            # ??a ch? chu?i g?c
    la      $t1, name             # ??a ch? ?? l?u name
    la      $t2, mssv              # ??a ch? ?? l?u age
    la      $t3, diachi   # ??a ch? ?? l?u other_name
    la      $t7, age
    la      $t6, religion 
    li      $t4, 0                # ??m s? l??ng d?u ph?y

loop:
    lb      $t5, 0($t0)           # L?y ký t? hi?n t?i trong strIn
    beq     $t5, 0, end_parse     # N?u là null byte (k?t thúc chu?i), thoát vòng l?p

    beq     $t5, ',', comma_found # N?u là d?u ph?y, x? lý tách chu?i

    # Ghi ký t? vào ph?n t??ng ?ng d?a trên s? d?u ph?y ??m ???c
    beq     $t4, 0, save_name     # N?u ch?a g?p d?u ph?y nào, l?u vào name
    beq     $t4, 1, save_mssv      # N?u ?ã g?p 1 d?u ph?y, l?u vào age
    beq     $t4, 2, save_diachi   # N?u ?ã g?p 2 d?u ph?y, l?u vào other_name
    beq     $t4, 3, save_age
    beq     $t4, 4, save_religion
    j       next_char

save_name:
    sb      $t5, 0($t1)           # L?u ký t? vào name
    addi    $t1, $t1, 1           # T?ng ??a ch? l?u name
    j       next_char

save_mssv:
    sb      $t5, 0($t2)           # L?u ký t? vào age
    addi    $t2, $t2, 1           # T?ng ??a ch? l?u age
    j       next_char

save_diachi:
    sb      $t5, 0($t3)           # L?u ký t? vào other_name
    addi    $t3, $t3, 1           # T?ng ??a ch? l?u other_name
    j       next_char
    
save_age:
    sb      $t5, 0($t7)           # L?u ký t? vào other_name
    addi    $t7, $t7, 1           # T?ng ??a ch? l?u other_name
    j       next_char
    
save_religion:
    sb      $t5, 0($t6)           # L?u ký t? vào other_name
    addi    $t6, $t6, 1           # T?ng ??a ch? l?u other_name
    j       next_char

comma_found:
    addi    $t4, $t4, 1           # T?ng s? l??ng d?u ph?y ?ã g?p
    j       next_char

next_char:
    addi    $t0, $t0, 1           # T?ng ??a ch? strIn ?? ??c ký t? ti?p theo
    j       loop                  # Quay l?i ??u vòng l?p

end_parse:
    sb      $zero, 0($t1)         # K?t thúc chu?i name b?ng null byte
    sb      $zero, 0($t2)         # K?t thúc chu?i age b?ng null byte
    sb      $zero, 0($t3)         # K?t thúc chu?i other_name b?ng null byte
    sb      $zero, 0($t6)
    sb      $zero, 0($t7)

# DONG 1
    li $v0, 4
    la $a0, dong1
    syscall
    
    
# DONG 2
    li $v0, 4
    la $a0, dong2
    syscall
  
  	li $v0, 4
	la $a0, name
	syscall

	addi $a0, $0, '\n' # Display character ’A’
    li $v0, 11 # print char
    syscall

# DONG 3
    li $v0, 4
    la $a0, dong3
    syscall
  
  	li $v0, 4
	la $a0, mssv
	syscall

	addi $a0, $0, '\n' # Display character ’A’
    li $v0, 11 # print char
    syscall
    
# DONG 4
    li $v0, 4
    la $a0, dong4
    syscall
  
  	li $v0, 4
	la $a0, diachi
	syscall

	addi $a0, $0, '\n' # Display character ’A’
    li $v0, 11 # print char
    syscall

# DONG 5
    li $v0, 4
    la $a0, dong5
    syscall
  
  	li $v0, 4
	la $a0, age
	syscall

	addi $a0, $0, '\n' # Display character ’A’
    li $v0, 11 # print char
    syscall

# DONG 6
    li $v0, 4
    la $a0, dong6
    syscall
  
  	li $v0, 4
	la $a0, religion
	syscall

	addi $a0, $0, '\n' # Display character ’A’
    li $v0, 11 # print char
    syscall


##############################################################################################

    li 		$v0, 13                       # Syscall ?? m? file (13)
    la 		$a0, OutputFile # ???ng d?n ??n file
    li 		$a1, 1                        # M? file ?? ghi (O_WRONLY)
    li 		$a2, 0                        # Ch? ?? (m?c ??nh)
    syscall                          # G?i h? th?ng
    
    move 	$t0, $v0
    
# DONG 1    
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, dong1                     # D? li?u ?? ghi
    li 		$a2, 34                       # Kích th??c d? li?u (42 byte)
    syscall                          # G?i h? th?ng
    
    
# DONG 2
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, dong2                    # D? li?u ?? ghi
    li 		$a2, 6                       # Kích th??c d? li?u (42 byte)
    syscall                          # G?i h? th?ng

    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, name                     # D? li?u ?? ghi
    li 		$a2, 32                       # Kích th??c d? li?u (42 byte)
    syscall            

    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, n                     # D? li?u ?? ghi
    li 		$a2, 1                       # Kích th??c d? li?u (42 byte)
    syscall            

# DONG 3
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, dong3                     # D? li?u ?? ghi
    li 		$a2, 3                       # Kích th??c d? li?u (42 byte)
    syscall                          # G?i h? th?ng

    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, mssv                     # D? li?u ?? ghi
    li 		$a2, 20                       # Kích th??c d? li?u (42 byte)
    syscall    

    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, n                     # D? li?u ?? ghi
    li 		$a2, 1                       # Kích th??c d? li?u (42 byte)
    syscall                    

# DONG 4
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, dong4                     # D? li?u ?? ghi
    li 		$a2, 9                       # Kích th??c d? li?u (42 byte)
    syscall                          # G?i h? th?ng

    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, diachi                    # D? li?u ?? ghi
    li		$a2, 64                       # Kích th??c d? li?u (42 byte)
    syscall    
   
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, n                     # D? li?u ?? ghi
    li 		$a2, 1                       # Kích th??c d? li?u (42 byte)
    syscall                 

# DONG 5
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, dong5                     # D? li?u ?? ghi
    li 		$a2, 5                       # Kích th??c d? li?u (42 byte)
    syscall                          # G?i h? th?ng

    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, age                     # D? li?u ?? ghi
    li 		$a2, 8                       # Kích th??c d? li?u (42 byte)
    syscall        
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, n                     # D? li?u ?? ghi
    li 		$a2, 1                       # Kích th??c d? li?u (42 byte)
    syscall                

# DONG 6
    
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, dong6                     # D? li?u ?? ghi
    li 		$a2, 10                       # Kích th??c d? li?u (42 byte)
    syscall                          # G?i h? th?ng
    
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, religion                     # D? li?u ?? ghi
    li 		$a2, 8                       # Kích th??c d? li?u (42 byte)
    syscall
    li 		$v0, 15                       # Syscall ?? ghi vào file (15)
    move 	$a0, $t0                    # Descriptor file
    la 		$a1, n                     # D? li?u ?? ghi
    li 		$a2, 1                       # Kích th??c d? li?u (42 byte)
    syscall                        

    
Exit:
