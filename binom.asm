.text
    
main: li $a0, 6             # n = 6
      li $a1, 4             # k = 4
      jal cnk
      move $a0, $v0
      li $v0, 1
      syscall
      li $v0, 10
      syscall

cnk:  slt $t0, $a0, $a1    # if n < k, $t0 = 1 else $t0 = 0
      bne $t0, $zero, end1 # if $t0 != 0, then go to end1
      beq $a0, $a1, end2   # if n = k, then go to end2
      beq $a1, $zero, end2 # if k = 0, then go to end2
      
      sw $ra, ($sp)        # store the adress of return
      addi $sp, $sp, -4    # update stack size
      sw $a0, ($sp)        # store n
      addi $sp, $sp, -4    # update stack size
      sw $t1, 0($sp)       # $t1 will be used to store the result of Cnk
      addi $sp, $sp, -4    # update stack size
      subi $a0, $a0, 1     # compute n-1
      jal cnk
      
      move $t1, $v0        # $t1 = c(n-1)(k)
      sw $a1, ($sp)        # store k
      addi $sp, $sp, -4    # update stack size
      sw $ra, ($sp)        # store the adress of return
      addi $sp, $sp, -4    # update stack size
      subi $a1, $a1, 1     # compute k-1
      jal cnk
      
      add $v0, $v0, $t1    # Cnk = C(n-1)(k-1) + C(n-1)k
      lw $ra, 4($sp)       # get back the adress of return
      lw $a1, 8($sp)       # get back k
      lw $t1, 12($sp)      # get back the result of previous Cnk
      lw $a0, 16($sp)      # get back n
      lw $ra, 20($sp)      # get back the adress of return
      addi $sp, $sp, 20    # update stack size
      
      j complete 
      
end1: move $v0, $zero
      j complete

end2: addi $v0, $zero, 1

complete:  jr $ra
