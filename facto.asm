.text
    
main: li $a0, 6
      jal fact
      move $v0, $a0
      li $v0, 1
      syscall
      li $v0, 10
      syscall

fact: beq $a0 $zero, fin    # if n = 0, return 1
      sw $ra, 0($sp)        # store the adress of return
      sw $a0, -4($sp)       # store n
      addi $sp, $sp, -8     # update the stack size
      subi $a0, $a0, 1      # compute n-1
      jal fact              # compute (n-1)!
      move $v0, $a0         # store in $v0 (n-1)!
      lw $a0, 4($sp)        # $a0 = n
      lw $ra, 8($sp)        
      addi $sp, $sp, 8      # update the stack size
      mul $a0, $a0, $v0     # $a0 = n!
      jr $ra
      
fin:  addi $a0, $a0, 1
      jr $ra
      