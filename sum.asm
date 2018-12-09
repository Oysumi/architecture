.data
a0 : .word 4 : 25
a1 : .word 0

.text

main:   la $a0, a0            # $a0 = adress of the array a0
        la $a1, a1            # $a1 = adress of a1
        li $a2, 0             # $a2 = 0 and will be used to know the denominator of our average function         
        jal avg               # go to the average function
        add $a0, $v0, $zero
        li $v0, 1
        syscall
        li $v0, 10
        syscall

avg:	sw $ra, 0($sp)        # store the adress of the main where we called avg
	sw $a0, -4($sp)
	addi $sp, $sp, -8     # update the stack size
	jal sum 
	lw $a0, 4($sp)
	lw $ra, 8($sp)        # get the adress of the main
	addi $sp, $sp, 8      # update the stack size
	sub $t0, $a1, $a0     # compute the number of elements of the array
	div $t0, $t0, 4
	div $v0, $t0          # divide the sum by the number of elements in the array
	mflo $v0              # get the result from the division
	jr $ra

sum:  	li $v0, 0
     	
loop:  	beq $a0, $a1, suite
	lw $t1, 0($a0)
	add $v0, $v0, $t1
	addi $a0, $a0, 4
	j loop
	
suite:	jr $ra

