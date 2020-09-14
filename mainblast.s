.data
space: .asciiz "\n"
enterArr1: 	.asciiz "Enter The Size of the 1st list: "
enterArr2: 	.asciiz "Enter The Size of the 2nd list: "
enterArr3: 	.asciiz "Enter The Size of the 3rd list: "
arr1SortType: 	.asciiz "Which Sort type for 1st List\n\n1- bubble sort\n2- merge sort \n3- quick sort\nYour choice: "
arr2SortType: 	.asciiz "Which Sort type for 2nd List\n\n1- bubble sort\n2- merge sort \n3- quick sort\nYour choice: "
arr3SortType: 	.asciiz "Which Sort type for 3rd List\n\n1- bubble sort\n2- merge sort \n3- quick sort\nYour choice: "

List1:    	  .word 	0:15
List2:    	  .word 	0:15
List3:    	  .word 	0:15
#--------------------------------------------------------
left_array:       .word         0:15
right_array:      .word         0:15
sizeLeft:         .word         0
sizeRight:        .word         0
mid:              .word         0
first_counter:    .word         0
#--------------------------------------------------------
list1sz:      .word
list2sz:      .word
list3sz:      .word


.text

   # Print For Scan 1st list size
   li $v0, 4
   la $a0, enterArr1
   syscall
   
   ##### Get 1st list size ####
   li $v0, 5           # Getting input
   syscall
   sw $v0, list1sz($zero)
   addi $s0, $zero, 4
   mul $t1, $s0, $v0

   li $t0, 0  #index of array

  
  while_scan_arr1:
    beq $t0, $t1 , exit_scan_arr1
        
    li $v0, 5           # Getting input
    syscall
        
    sw $v0 , List1($t0)  # Store input element to Array
    addi $t0 , $t0, 4   # add 4 bit to Go for next Index in Array 
    j while_scan_arr1
  exit_scan_arr1:  
   # Print For Scan 2nd list size
   li $v0, 4
   la $a0, enterArr2
   syscall
   ##### Get 2nd list size ####
   li $v0, 5           # Getting input
   syscall
   addi $s0, $zero, 4
   mul $t1, $s0, $v0

   li $t0, 0  #index of array
   while_scan_arr2:
    beq $t0, $t1 , exit_scan_arr2
        
    li $v0, 5           # Getting input
    syscall
        
    sw $v0 , List2($t0)  # Store input element to Array
    addi $t0 , $t0, 4   # add 4 bit to Go for next Index in Array 
    j while_scan_arr2
   exit_scan_arr2: 
   # Print For Scan 3rd list size
   li $v0, 4
   la $a0, enterArr3
   syscall
   ##### Get 3rd list size ####
   li $v0, 5           # Getting input
   syscall
   addi $s0, $zero, 4
   mul $t1, $s0, $v0

   li $t0, 0  #index of array
   while_scan_arr3:
    beq $t0, $t1 , exit_scan_arr3
        
    li $v0, 5           # Getting input
    syscall
        
    sw $v0 , List3($t0)  # Store input element to Array
    addi $t0 , $t0, 4   # add 4 bit to Go for next Index in Array 
    j while_scan_arr3
    exit_scan_arr3: 
    # For Printint title Msg
    li $v0, 4
    la $a0, arr1SortType
    syscall
    # scan array sort type
    li $v0, 5
    syscall
    
    addi $t0, $zero, 1
    addi $t1, $zero, 2
    addi $t2, $zero, 3
    
    la $a0, List1
    lw $a1, list1sz
    #beq $v0, $t0, bubbleSort
    beq $v0, $t1, mergesort
    #beq $v0, $t2, quicksort
    syscall
      # For Printint title Msg
    li $v0, 4
    la $a0, arr2SortType
    syscall
    # scan array sort type
    li $v0, 5
    syscall
    
    addi $t0, $zero, 1
    addi $t1, $zero, 2
    addi $t2, $zero, 3
    
    la $a0, List2
    lw $a1, list2sz
    #beq $v0, $t0, bubbleSort
    beq $v0, $t1, mergesort
    #beq $v0, $t2, quicksort
    syscall
      # For Printint title Msg
    li $v0, 4
    la $a0, arr3SortType
    syscall
    # scan array sort type
    li $v0, 5
    syscall
    
    addi $t0, $zero, 1
    addi $t1, $zero, 2
    addi $t2, $zero, 3
    
    la $a0, List3
    lw $a1, list3sz
    #beq $v0, $t0, bubbleSort
    beq $v0, $t1, mergesort
    #beq $v0, $t2, quicksort
    syscall
   
 
  
#------------------------------merge sort function ----------------------------------

 mergesort:
   
     move $t1, $a0                          # load t1 <-- array address
     move $t6, $a1                          # load value t1 <-- list_size(max index)

     la $t2, left_array                  # load t2 <-- left_array address
     la $t3, right_array                 # load t3 <-- right_array address

     lw $t4, first_counter               # load first for loop incrementation start
     lw $s6, sizeLeft                    # load sizeLeft into register s6
     lw $s7, sizeRight                   # load sizeRight into register s7
     li $t8, 2                           # t8 <-- 2
     li $t9, 1                           # t9 <-- 1
          
     divu $s0, $t6, $t8                  # (t6/t8) list_size / 2 
     
     lw $t7, mid                         # load value t3 <-- mid
     move $t7, $s0                         # t3 <-- t14 (mid = list_size/2)
     
     sub $s1, $t7, $t9                   # s1 = t3 - t4 (mid - 1 )
     sub $s4, $t6, $t7                   # s4 = t6 - t7 (list_size - mid) 
     
     add $t5, $zero, $t7                 # t5 = 0 + t7  ( y = mid ) 

     slt $s0, $t7, $t8                   # s0 = t1 < 2 ( is list_size < 2 ) 
     bne $s0, $zero, return              # if equal to 0 (list_size"t1" not < 2 )

return : 
  jr $ra 
   
#--------------------------------
  first_for_loop:  
     bleu $t1, $s1, goto_for_loop     # branch if t2 <= t4 (i <= mid-1 ) 
 
 goto_for_loop:
     lw $s2, 0($t1)                    # get s2 <-- array[i]
     lw $s3, 0($t2)                    # get s3 <-- left_array[i]
     move $s3, $s2                       # left_array[i] = array[i]
     addi $t1, $t1, 4                  # increment array pointer
     addi $t2, $t2, 4                  # increment left_array pointer
     addi $t4, $t4, 1                  # t4 = t4 + 1 (i++)
     addi $s6, $s6, 1                  # sizeLeft = sizeLeft + 1 
     j first_for_loop                       # go back to loop
#------------------------------
   second_for_loop:
     bleu $t5, $s4, goto_second_for_loop   # branch if t5 <= s4 (j <= list_size-mid) 

   goto_second_for_loop:
     lw $s2, 0($t1)                    # get s2 <-- array[j]
     lw $s5, 0($t3)                    # get s5 <-- right_array[j]
     move $s5, $s2                      # rightt_array[j] = array[j]
     addi $t1, $t1, 4                  # increment array pointer
     addi $t3, $t3, 4                  # increment right_array pointer
     addi $t5, $t5, 1                  # t5 = t5 + 1 (j++)
     addi $s7, $s7, 1                  # sizeRight = sizeRight + 1 
     j second_for_loop                       # go back to loop

###-------------------------------
   procedures_call:
   addi $sp, $sp, -32                  # reserving memory in stack for saving
   sw $t1, 28($sp)
   sw $t2, 24($sp)
   sw $t3, 20($sp)
   sw $t4, 16($sp)
   sw $t5, 12($sp)
   sw $t6, 8($sp)
   sw $t7, 4($sp)
   sw $t8, 0($sp)

   move $a0, $t2                         # put left_array to first argument
   move $a1, $s6                        # put sizeLeft to second argument
   jal mergesort                       # call merge sort function

   move $a0, $t3                        # put right_array to first argument
   move $a1, $s7                        # put rightLength to first argument
   jal mergesort

   move $a0, $t1                     # put array to first argument
   move $a1, $t2                     # put left_array to second argument
   move $a2, $t3                     # put right_array to third argument
   move $a3, $s6                     # put sizeLeft to fourth argument
   addi $sp, $sp, -4                 # preserving memory in stack
   sw $s7, 0($sp)                    # moving fifth (sizeRight) argument in stack

   jal merge

   lw $t8, 0($sp)
   lw $t7, 4($sp)
   lw $t6, 8($sp)
   lw $t5, 12($sp)
   lw $t4, 16($sp)
   lw $t3, 20($sp)
   lw $t2, 24($sp)
   lw $t1, 28($sp)
   addi $sp, $sp, 32                  # returning back memory to stack after retrieving

Exit_merge:
 jr $ra                               # returning from function

#------------------------------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------------------------------------------
merge: 

   addi $sp ,$sp, -32                          # saving callee saved registers in stack 
    sw $s0, 28($sp)
    sw $s1, 24($sp)
    sw $s2, 20($sp)
    sw $s3, 16($sp)
    sw $s4, 12($sp)
    sw $s5, 8($sp)
    sw $s6, 4($sp)
    sw $s7, 0($sp)

   move $t1, $a0                                # load t1 <-- arr
   move $t2, $a1                                # load t2 <-- left_array
   move $t3, $a2                                # load t3 <-- right_array
   move $s7, $a3                                # load s7 <-- sizeLeft
   lw $s6, 0($sp)                               # load s8 <-- sizeRight

   li $t4,0                                     # int i = 0
   li $t5,0                                     # int j = 0
   li $t6 0                                     # int k = 0

   slt $s0, $t4, $s7                            # is i < sizeLeft ?
   slt $s1, $t5, $s6                            # is j < sizeRight ? 

   and $s2, $s0, $s1                            # s0 && s1
   

while: 
     beq $s2, $zero, second_while                  # if s2 == 0 goto second_while 
     lw $s3, 0($t1)                              # get s3 <- arr[i]
     lw $s4, 0($t2)                              # get s4 <- left[i]
     lw $s5, 0($t3)                              # get s5 <- right[i]


   If: bleu $s4, $s5, do_if                      # while (left[i] <= right[j])
   
  do_if: move $s4, $s3                             # arr[k] = left[i]
         addi $t4, $t4, 1                         # i= i + 1 
         addi $t1, $t1, 4                         # increment array value by 4 (next index) 
         addi $t2, $t2, 4                         # increment left_array value by 4 

  Else: 
        move $s5, $s3                            # arr[k] = right[j]
        addi $t5, $t5, 1                         # j = j + 1 
        addi $t1, $t1, 4                         # increment array value by 4 (next index) 
        addi $t3, $t3, 4                         # increment right_array value by 4 

                                                 
     addi $t6, $t6, 1                              # k = k + 1
     j while                                      # goto while again

second_while:
    bltu $t4, $s7, do_second_while              # if i < left_length

do_second_while:
    move $s4, $s3                                 # arr[k] = left[i]
    addi $t1, $1, 1                             # increment array value by 4 (next index) 
    addi $t2, $t2, 1                            # increment left_array value by 4 
    addi $t4, $t4, 1                            # i = i + 1 
    addi $t6, $t6, 1                            # k = k + 1 
    j second_while                              # goto second_while again

third_while:
    bltu $t5, $s6, do_third_while               # if j < right_length

    do_third_while:
    move $s5, $s3                                # arr[k] = right[j]
    addi $t1, $1, 1                             # increment array value by 4 (next index) 
    addi $t3, $t3, 1                            # increment right_array value by 4 
    addi $t5, $t5, 1                            # j = j + 1 
    addi $t6, $t6, 1                            # k = k + 1 
    j third_while                               # goto third while again

    
Exit :
    lw $s7, 0($sp)
    lw $s6, 4($sp)
    lw $s5, 8($sp)
    lw $s4, 12($sp)
    lw $s3, 16($sp)
    lw $s2, 20($sp)
    lw $s1, 24($sp)
    lw $s0, 28($sp) 
    addi $sp ,$sp, 32                           # returning callee saved registers from stack 

    jr $ra                                      # return from where you get here


