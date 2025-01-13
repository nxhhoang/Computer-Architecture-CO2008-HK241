.data
prompt_circle: .asciiz "Number of points within the circle: "
POINTS: .asciiz "/50000\n"
prompt_pi: .asciiz "Calculated PI number: "
file_name: .asciiz "C:\\Users\\ASUS\\Documents\\MIPS\\PI.txt"
count_circle: .word 0
count_total: .word 50000
four: .float 4.0
one: .float 0.25
half: .float 0.5

.text
main:
	

    # Seed random generator
    li $v0, 30           # Syscall to get time
    syscall
    move $a0, $v0
    li $v0, 40           # Syscall to set seed
    syscall
    
    lwc1 $f5, one
    
    # Initialize counters
    li $t0, 0            # Count points within the circle
    li $t1, 0            # Total points (50000)

loop:
    # Generate random x and y in range [0,1)
    li $v0, 43           # Random float syscall
    syscall
    mov.s $f8, $f0      # Store x in $f0

    li $v0, 43           # Random float syscall
    syscall
    mov.s $f1, $f0      # Store y in $f1

    # Calculate x^2 + y^2
    lwc1 $f9, half
    sub.s $f8, $f8, $f9  # x - 1/2
    sub.s $f1, $f1, $f9  # y - 1/2
    mul.s $f2, $f8, $f8  # f2 = x^2
    mul.s $f3, $f1, $f1  # f3 = y^2
    add.s $f4, $f2, $f3  # f4 = x^2 + y^2

    # Check if point is within the circle (x^2 + y^2 <= 0.25)
    lwc1 $f5, one
    c.le.s $f4, $f5      # If x^2 + y^2 <= 0.25
    bc1t inside_circle   # Branch if true

outside_circle:
    j continue

inside_circle:
    addi $t0, $t0, 1     # Increment count of points within circle

continue:
    addi $t1, $t1, 1     # Increment total count
    li $t2, 50000
    bne $t1, $t2, loop   # Repeat until 50000 points

    # Calculate PI as 4 * (points_in_circle / total_points)
    mtc1 $t0, $f6        # Move points_in_circle to $f6
    cvt.s.w $f6, $f6     # Convert to float
    mtc1 $t2, $f7        # Move total_points to $f7
    cvt.s.w $f7, $f7     # Convert to float
    div.s $f8, $f6, $f7  # f8 = points_in_circle / total_points
    lwc1 $f9, four 
    mul.s $f10, $f8, $f9 # f10 = calculated PI

    # Print results to console
    # Number of points within the circle
    li $v0, 4
    la $a0, prompt_circle
    syscall
    move $a0, $t0
    li $v0, 1            # Print integer
    syscall
    
    # Total points label
    li $v0, 4
    la $a0, POINTS
    syscall

    # Calculated PI
    li $v0, 4
    la $a0, prompt_pi
    syscall
    mov.s $f12, $f10
    li $v0, 2            # Print float
    syscall

    # Exit program
    li $v0, 10
    syscall
