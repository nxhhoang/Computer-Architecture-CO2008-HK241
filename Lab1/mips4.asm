.data
prompt: .asciiz "Please enter a positive integer less than 16: "
output: .asciiz "Its binary form is: "

.text
main:

li      $v0, 4  
la      $a0, prompt 
syscall



li	$v0, 5
syscall
add  $t5, $0, $v0

addi $t2, $0, 1

addi $t4, $0, 0
##########################
div  $t5, $t5, 2  
mfhi $t9


##########################
div  $t5, $t5, 2
mfhi $t8

##########################
div  $t5, $t5, 2 
mfhi $t7

##########################
div  $t5, $t5, 2
mfhi $t6

li      $v0, 4  
la      $a0, output 
syscall

#######################
add  $a0, $zero, $t6
li   $v0, 1
syscall

add  $a0, $zero, $t7
li   $v0, 1
syscall

add  $a0, $zero, $t8
li   $v0, 1
syscall

add  $a0, $zero, $t9
li   $v0, 1
syscall
#######################


li   	$v0, 10   
syscall


   