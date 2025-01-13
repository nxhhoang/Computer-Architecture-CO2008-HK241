# Program: Hello, name!
.data
name: 		.asciiz "Hello, "
a: "\n"
strIn: 		.space 100

.text
main:

la 	$a0,	strIn
addi	$a1,	$0,	10
li	$v0, 	8
syscall

li	$v0, 	4
la	$a0, 	name
syscall

li	$v0, 	4
la	$a0, 	strIn
syscall

addi	$a0,	$0,	'!'
li	$v0, 	11
syscall

li	$v0, 	4
la	$a0, 	a
syscall
