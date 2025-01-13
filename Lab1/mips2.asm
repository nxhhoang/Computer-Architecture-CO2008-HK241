# Program: Hello, name!
.data
array:      	.space 20 
prompst1:	.asciiz "Please input element 0: "
prompst2:	.asciiz "Please input element 1: "
prompst3:	.asciiz "Please input element 2: "
prompst4:	.asciiz "Please input element 3: " 
prompst5:	.asciiz "Please input element 4: "

index:		.asciiz "Please enter index: "


.text
main:

li      $t0, 0

li      $v0, 4  
la      $a0, prompst1 
syscall

li	$v0, 5
syscall
sw      $v0, array($t0)
addi    $t0, $t0, 4
##############################

li      $v0, 4  
la      $a0, prompst2 
syscall

li	$v0, 5
syscall
sw      $v0, array($t0)
addi    $t0, $t0, 4
##############################

li      $v0, 4  
la      $a0, prompst3 
syscall

li	$v0, 5
syscall
sw      $v0, array($t0)
addi    $t0, $t0, 4
##############################

li      $v0, 4  
la      $a0, prompst4 
syscall

li	$v0, 5
syscall
sw      $v0, array($t0)
addi    $t0, $t0, 4
##############################

li      $v0, 4  
la      $a0, prompst5 
syscall

li	$v0, 5
syscall
sw      $v0, array($t0)
##############################

li      $v0, 4  
la      $a0, index 
syscall

li $v0, 5 # Get integer mode,
# $v0 contains integer read
syscall
add $s0, $0, $v0

la  $t0, array
add $t2, $s0, $s0
add $t2, $t2, $t2

add $t1, $t0, $t2
lw  $t3, 0($t1)

add  $a0, $zero, $t3
li   $v0, 1
syscall