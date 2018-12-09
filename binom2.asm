.text
    
main: li $a0, 6             # n = 6
      li $a1, 4             # k = 4
      jal cnk
      move $a0, $v0
      li $v0, 1
      syscall
      li $v0, 10
      syscall

cnk:      slt     $t0, $a0, $a1         # $t0 <- 1 if n < m 
          bne     $t0, $zero, end1      # if ($t0) = 1 then goto exit1
          beq     $a0, $a1, end2        # if (n == m) then goto exit2
          beq     $a1, $zero, end2      # if (m == 0) then goto exit2
          
          sw      $fp, -4($sp)
          addi    $fp, $sp, 0
          addi    $sp, $sp, -12
          sw      $ra, 4 ($sp)
          sw      $a0, 0 ($sp)
          addi    $sp, $sp, -4
          sw      $t1, ($sp)
          addi    $a0, $a0, -1
          jal     cnk
          
          move    $t1, $v0
          addi    $sp, $sp, -4
          sw      $a1, ($sp)
          addi    $sp, $sp, -4
          sw      $ra, ($sp) 
          
          addi    $a1, $a1, -1
          
          jal     cnk
          
          add     $v0, $t1, $v0
 
          lw      $ra, ($sp)
          addi    $sp, $sp, 4
          
          lw      $a1, ($sp)
          addi    $sp, $sp, 4
          
          lw      $t1, ($sp)
          addi    $sp, $sp, 4
          
          lw      $a0, ($sp)
          addi    $sp, $sp, 4
          lw      $ra, ($sp)
          addi    $sp, $sp, 4
          lw      $fp, ($sp)
          addi    $sp, $sp, 4
          j       complete 
      
end1: move $v0, $zero
      j complete

end2: addi $v0, $zero, 1

complete:  jr $ra
