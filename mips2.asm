
# computes the binomial coefficients C(n,m) using the recursive formula C(n,m) = C(n-1,m) + C(n-1, m-1)
############################################################################
.text
        .globl  __start
__start:
        li      $v0, 4           # mesg1 asking for a number
        la      $a0, msg1
        syscall
        li      $v0,5           # system call that reads an integer
        syscall
        move    $t0, $v0
        
        li      $v0, 4           # mesg2 asking for a number
	la      $a0, msg2
	syscall
	li      $v0,5           # system call that reads an integer
        syscall
        move    $a0, $t0
        move    $a1, $v0
        jal binomial
####################################### end of procedure call
        move    $t0, $v0
          
        li      $v0, 4          # print mesg3
	la      $a0, msg3
        syscall
  
	move    $a0, $t0
        li      $v0,1           # print C(n,m)
	syscall

	li      $v0,4           # print an end of line
	la      $a0, cr
	syscall

	li      $v0,10          # exit
	syscall
####################################### display the result and terminate

binomial: slt     $t0, $a0, $a1          # $t0 <- 1 if n < m 
          bne     $t0, $zero, exit1      # if ($t0) = 1 then goto exit1
          beq     $a0, $a1, exit2        # if (n == m) then goto exit2
          beq     $a1, $zero, exit2      # if (m == 0) then goto exit2
          
          sw      $fp, -4($sp)
          addi    $fp, $sp, 0
          addi    $sp, $sp, -12
          sw      $ra, 4 ($sp)
          sw      $a0, 0 ($sp)
          addi    $sp, $sp, -4
          sw      $t1, ($sp)
          addi    $a0, $a0, -1
          jal     binomial
          
          move    $t1, $v0
          addi    $sp, $sp, -4
          sw      $a1, ($sp)
          addi    $sp, $sp, -4
          sw      $ra, ($sp) 
          
          addi    $a1, $a1, -1
          
          jal     binomial
          
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
          j       done
          
 exit1:   move    $v0, $zero         
          j       done
          
 exit2:   addi    $v0, $zero, 1
          
 done:    jr      $ra       
#########################################################################        
.data
msg1:   .asciiz "Enter n "

msg2:   .asciiz "Enter m "
msg3:   .asciiz "The value of C(n,m) = "
cr:     .asciiz "\n"