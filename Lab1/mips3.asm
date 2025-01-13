# Program: Hello, name!
.data
prompt1:	.asciiz "Insert a: "
prompt2:	.asciiz "Insert b: "
prompt3:	.asciiz "Insert c: "
prompt4:	.asciiz "Insert d: "

F: 		.asciiz "F = "
remainder:	.asciiz ", remainder: "


.text
main:

li	$v0, 	4
la	$a0, 	prompt1
syscall

li $v0, 5 # Get integer mode,
# $v0 contains integer read
syscall
add $s0, $0, $v0
#---------------------------------------
li	$v0, 	4
la	$a0, 	prompt2
syscall

li $v0, 5 # Get integer mode,
# $v0 contains integer read
syscall
add $s1, $0, $v0
#---------------------------------------
li	$v0, 	4
la	$a0, 	prompt3
syscall

li $v0, 5 # Get integer mode,
# $v0 contains integer read
syscall
add $s2, $0, $v0
#---------------------------------------
li	$v0, 	4
la	$a0, 	prompt4
syscall

li $v0, 5 # Get integer mode,
# $v0 contains integer read
syscall
add $s3, $0, $v0
#---------------------------------------

addi $t0, $s0, 10  # a + 10
sub  $t1, $s1, $s3 # b - d
add  $t2, $s0, $s0
sub  $t3, $s2, $t2 # c - 2 * a

mul  $t5, $t0, $t1
mul  $t5, $t5, $t3

add  $t4, $s0, $s1
add  $t4, $t4, $s2

div  $t5, $t4 
mflo $t6 
mfhi $t7

li	$v0, 	4
la	$a0, 	F
syscall

add  $a0, $zero, $t6 
li   $v0, 1
syscall

li	$v0, 	4
la	$a0, 	remainder
syscall

add  $a0, $zero, $t7 
li   $v0, 1
syscall

li   	$v0, 10   
syscall