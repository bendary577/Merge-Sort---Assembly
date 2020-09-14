.data
.globl main
arr1:   		.word   0:15
arr2:   		.word   0:15
diff_indices:           .word   0:32
arr3:			.word   0:30

nl :			.asciiz "\n"
tb :			.asciiz "\t"
first :			.asciiz "\n1st Sorted Array:\t"
second :		.asciiz "\n2st Sorted Array:\t"
diff  :			.asciiz "\nDiffrent Indices:\n"
lst1_out :		.asciiz "List1 with index : ["
lnd2_out :		.asciiz "List2 with index : ["
lgrp_out :		.asciiz "\nGrouped & Sorted Array:\t"
qu : 			.asciiz "] \n"
entr_1 : 		.asciiz "Enter the elements of 1st List :)\n"
entr_2 :		.asciiz "Enter the elements of 2nd List :)\n"
key_out	:		.asciiz " exists in the list at ["
keyn_out : 		.asciiz " not exists in the list\n"

.text
main:
	la $a0 , arr1                                                                                        # load the address of arr1 in $a0
	la $a1 , arr2				                                                             # load the address of arr2 in $a1
	la $a2 , diff_indices                                                                                # load the address of diff_indices in $a2
	la $a3 , arr3                                                                                        # load the address of arr3 in $a3
	
	jal readArr				 	                                                     # calling readArr
	la $a0 , arr1				                                                             # pass argument 1 "the list" to sortArr "sortArr(arr1,15)"
	la $a1 , 15					                                                     # pass argument 2 "the size" to sortArr "sortArr(arr1,15)"
	jal sortArr					                                                     # calling sortArr(arr1,15)
	la $a0 , arr2				                                                             # pass argument 1 "the list" to sortArr "sortArr(arr2,15)"
	la $a1 , 15					                                                     # pass argument 2 "the size" to sortArr "sortArr(arr2,15)"
	jal sortArr			 		                                                     # calling sortArr(arr2,15)
	jal compareArrs                                                                                      # calling compareArrs 
	jal groupArrs                                                                                        # calling groupArrs
	jal printArr				                                                             # calling printArr
	la $a0 , arr2
	li $a1 , 15
	li $a2 , 14
	jal searchArr
	li $v0 , 10
	syscall
	
compareArrs:
	
	li $t0 , 0                                                                                             # int i
	li $t1 , 14                                                                                            # int size
	li $t5 , 0                                                                                             # int j
	li $t6 , 0                                                                                             # int counter_different
	
	outer_loop_1:                                                                                          # The First outer loop
		bgt $t0 , $t1 , exit_outer_loop_1                                                              # for i=0;i<15;
		sll $t3 , $t0 , 2                                                                              # t3 = 4 * i "Word addressing"
		add $t3 , $t3 , $a0                                                                            # M[arr + 4*i] "Make t3 on the address of the array: arr Like a pointer"
		lw $t4 , 0($t3)                                                                                # t4 = M[arr + 4*i] "Get the value of arr[i] for comparison"
		
		inner_loop_1: # inner_loop
			bgt $t5 , $t1 , exit_inner_loop_1                                                      # Check if the value of i less than 15 and If not exit the inner loop "for j=0;j<15;"
			sll $t2 , $t5 , 2                                                                      # for word addressing "t2 = 4*j" 
			add $t2 , $t2 , $a1                                                                    # M[arr2 + 4*i]
			lw $t7 , 0($t2)                                                                        # t7 = M[arr2 + 4*j]
			beq $t4 , $t7 , exit_inner_loop_1                                                      # if M[arr + 4*i] == M[arr2 + 4*j] "Equality checking"
			addi $t5 , $t5 , 1                                                                     # j++; "The increment of the inner_loop 'for j=0;j<15'"
			j inner_loop_1                                                                         # Return to inner_loop
			
		exit_inner_loop_1 :                                                                            # exit_inner_loop section (back from 1stloop)
			addi $t4 , $t1 , 1                                                                     # to make the size 15 for bgt condition
			bne $t5 ,  $t4 , exit_condition_1                                                      # branch if equal "if j != 15"
			addi $t6 , $t6 , 1                                                                     # counter_different+=1;
			addi $t4 , $t6 , 1                                                                     # counter_different + 1;
			sll $t7 , $t4 , 2                                                                      #(counter_different +1)* 4;
			add $t7 , $t7 , $a2                                                                    # M[diff_indices + 4*(counter_different+1)];
			sw $t0 , 0($t7)                                                                        # M[diff_indices + 4*(counter_different+1)] = i;
			exit_condition_1 : 
				li $t5 , 0                                                                     # j = 0;
		addi $t0 , $t0 , 1                                                                             # i++;
		j outer_loop_1                                                                                 # back to outer_loop
		exit_outer_loop_1 :                                                                            # from the outer loop
			sw $t6 , 0($a2)                                                                        # M[diff_indices + 0] = counter_different;
			li $t0 , 0                                                                             # i = 0;
	
	outer_loop_2:                                                                                          # The second outer_loop 
		bgt $t0 , $t1 , exit_outer_loop_2                                                              # for i=0;i<15;
		sll $t3 , $t0 , 2                                                                              # t3 = 4 * i
		add $t3 , $t3 , $a1                                                                            # M[arr2 + 4*i]
		lw $t4 , 0($t3)                                                                                # t4 = M[arr2 + 4*i]
		
		inner_loop_2:                                                                                  #inner_loop_2
			bgt $t5 , $t1 , exit_inner_loop_2                                                      # for j=0;j<15;
			sll $t2 , $t5 , 2                                                                      # t2 = 4*j
			add $t2 , $t2 , $a0                                                                    # M[arr + 4*i]
			lw $t7 , 0($t2)                                                                        # t7 = M[arr + 4*j]
			beq $t4 , $t7 , exit_inner_loop_2                                                      # if M[arr2 + 4*i] == M[arr + 4*j]
			addi $t5 , $t5 , 1                                                                     # j++;
		j inner_loop_2                                                                                 # back to inner_loop_2
			
		exit_inner_loop_2 :                                                                            # exit_inner_loop section (back from loop)
			addi $t4 , $t1 , 1                                                                     # to make the size 15 for bgt cond
			bne  $t5 ,$t4 ,exit_condition_2                                                        # branch if equal "if j != 15"
			addi $t6 , $t6 , 1                                                                     # counter_different+=1;
			addi $t4 , $t6 , 1                                                                     # counter_different + 1
			sll $t7 , $t4 , 2                                                                      # (counter_different +1)* 4;
			add $t7 , $t7 , $a2                                                                    # M[diff_indices + 4*(counter_different+1)];
			sw $t0 , 0($t7)                                                                        # M[diff_indices + 4*(counter_different+1)] = i;
			exit_condition_2 : 
				li $t5 , 0                                                                     # j = 0;
			addi $t0 , $t0 , 1                                                                     # i++;
	j outer_loop_2                                                                                         # back to outer_loop_2
		exit_outer_loop_2 :                                                                            # from the outer loop_2
			lw $t4 , 0($a2)                                                                        # t4 = M[diff_indices + 0*4];
			sub $t4 , $t6 , $t4                                                                    # t4 = counter_different - M[diff_indices + 0];
			sw $t4 , 4($a2)                                                                        # M[diff_indices + 1*4] = t4;
		
	jr $ra
	
sortArr:
	li $t0 , 0                                                                                             # int i = 0;
	outer_loop :                                                                                           # The outer loop 
		beq $t0 , $a1 , exit_outer_loop                                                                # "for i=0;i<=14"
			sll $t3 , $t0 , 2		                                                       # word addressing 
			add $t3 , $t3 , $a0		                                                       # make t3 as pointer of array beginning arr
			addi $t1 , $t0 , 1		                                                       # j = i + 1 "the variable of the second loop"
			inner_loop :			                                                       # the inner loop
				beq $t1 , $a1 , exit_inner_loop                                                # for j=0 ; j<=14 
					sll $t4 , $t1 , 2                                                      # word addressing
					add $t4 , $t4 , $a0                                                    # make t4 as pointer of array beginning arr
					lw $t7 , 0($t3)                                                        # take value of arr[i] in t7
					lw $t8 , 0($t4)	                                                       # take value of arr[j] in t8
					bgt $t7 , $t8 , condition                                              # if arr[i] > arr[j]
					j exit			                                               # jump to exit section
					condition :		                                               # condition that have the swap process
						lw $t5 , 0($t3)                                                # take value of arr[i] in t5
						lw $t6 , 0($t4)                                                # take value of arr[j] in t6
						sw $t5 , 0($t4)                                                # arr[j] = arr[i]
						sw $t6 , 0($t3)	                                               # arr[j] = arr[i]
					exit:				                                       # exit section to jump from condition section if the value little than
					addi $t1 , $t1 , 1                                                     # j = j + 1;
			j inner_loop			                                                       # back to inner_loop
			exit_inner_loop : 		# exit section of inner loop at t1 > 14
				addi $t0 , $t0 , 1	# i = i + 1
	j outer_loop					# jump to the outer loop
	exit_outer_loop : li $t0 , 0	# exit section of the outer loop
	la $a0 , arr1					# get back to the previous value of arr1 address
	la $a1 , arr2					# get back to the previous value of arr2 address
jr $ra								# return to program counter
	
groupArrs:
	li $t0, 0					    # Declaring and Initializing the counter (int i=0)
	loop:
		beq $t0, 30, End_Loop		# Branch to Exit, if($t0 == 30)
			sll $t3 , $t0 , 2
			add $t3 , $t3 , $a3
			bgt $t0, 14, Else		# Branch to Else, if(i > 14)
				sll $t1 , $t0 , 2
				add $t1 , $t1 , $a0
				lw $t4 , 0($t1)
				sw $t4 , 0($t3)
				j Continue
			Else:
				li $t5, 15
				sub $t5 , $t0 , $t5	# i=i-15
				sll $t2 , $t5 , 2   # shift to multiply the value of difference by 4 "4*i"
				add $t2 , $t2 , $a1 # reference to the array address "arr2"
				lw $t4 , 0($t2)     # load the value of arr2
				sw $t4 , 0($t3)		# store the value of arr2 into arr3[i]
		Continue:
			addi $t0, $t0, 1		# Counter increament (i++)
			j loop					# Jump to loop
	End_Loop:						# Exit from the loop when finished (Recalled above)
	la $a0 , arr3					# the list 		   "arg0"
	li $a1 , 30						# the size of list "arg1"
	j sortArr						# sort the joined list
	jr $ra							# return for program counter

printArr:
	li $t0 , 0 						# int i = 0;
			li $v0 , 4
			la $a0  , first
			syscall
			la $a0 , arr1
	first_loop:
		bgt $t0 , 14 , exit_first_loop
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a0
			lw $t2 , 0($t1)
			
			li $v0 , 1
			move $a0 , $t2
			syscall
			
			li $v0 , 4
			la $a0  , tb
			syscall
			
		addi $t0 , $t0 , 1
		la $a0 , arr1
	j first_loop
	exit_first_loop : li $t0 , 0
	
			li $v0 , 4
			la $a0  , second
			syscall
	
	second_loop:
		bgt $t0 , 14 , exit_second_loop
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a1
			lw $t2 , 0($t1)
			
			
			li $v0 , 1
			move $a0 , $t2
			syscall
			
			li $v0 , 4
			la $a0  , tb
			syscall
			
		addi $t0 , $t0 , 1
	j second_loop
	exit_second_loop : 
	
	li $v0 , 4
	la $a0 , diff
	syscall
	
	lw $t2 , 0($a2)
	li $t0 , 2
	addi $t2 , $t2 , 1
	
	third_loop:
		bgt $t0 , $t2 , exit_third_loop
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a2
			lw $t3 , 0($t1)
			
			li $v0 , 4
			la $a0  , lst1_out
			syscall
			
			li $v0 , 1
			move $a0 , $t3
			syscall
			
			li $v0 , 4
			la $a0  , qu
			syscall
			
		addi $t0 , $t0 , 1
	j third_loop
	exit_third_loop : 
	
	lw $t3 , 4($a2)
	add $t2 , $t2 , $t3
	
	fourth_loop:
		bgt $t0 , $t2 , exit_fourth_loop
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a2
			lw $t3 , 0($t1)
			
			li $v0 , 4
			la $a0  , lnd2_out
			syscall
			
			li $v0 , 1
			move $a0 , $t3
			syscall
			
			li $v0 , 4
			la $a0  , qu
			syscall
			
		addi $t0 , $t0 , 1
	j fourth_loop
	exit_fourth_loop : li $t0 , 0
	
	li $v0 , 4
	la $a0 , lgrp_out
	syscall
	
	fifth_loop:
		bgt $t0 , 29 , exit_fifth_loop
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a3
			lw $t3 , 0($t1)
			
			li $v0 , 1
			move $a0 , $t3
			syscall

			li $v0 , 4
			la $a0  , tb
			syscall
			
		addi $t0 , $t0 , 1
	j fifth_loop
	exit_fifth_loop : 
	
	la $a0 , arr1
	
jr $ra

readArr:
	li $t0 , 0 						# int i = 0;
	
	li $v0 , 4
	la $a0  , entr_1
	syscall
	la $a0 , arr1
	
	read_loop_1:
		bgt $t0 , 14 , exit_read_loop_1
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a0
			li $v0 , 5
			syscall
			sw $v0 , 0($t1)
		addi $t0 , $t0 , 1
	j read_loop_1
	exit_read_loop_1 : li $t0 , 0 
	
	li $v0 , 4
	la $a0  , entr_2
	syscall
	
	read_loop_2:
		bgt $t0 , 14 , exit_read_loop_2
			sll $t1 , $t0 , 2
			add $t1 , $t1 , $a1
			li $v0 , 5
			syscall
			sw $v0 , 0($t1)
		addi $t0 , $t0 , 1
	j read_loop_2
	exit_read_loop_2 : 
	
	la $a0 , arr1
jr $ra


searchArr:
		li $t1 , 0
		search_loop:
			bgt $t1, $a2, exit_loop
			sll $t6, $t1, 2
			addu $t6, $t6,$a0
			lw $t2,0($t6)
			beq $a1,$t2, exit_condition
			addi $t1, $t1, 1
			j search_loop
		exit_condition:
			li $v0, 4
			la $a0, nl
			syscall
			
			li $v0, 1
			move $a0 , $a1
			syscall
			
			li $v0, 4
			la $a0, key_out
			syscall
			
			li $v0, 1
			move $a0 , $t1
			syscall
			
			li $v0, 4
			la $a0, qu
			syscall
			
			j exit_cond
		exit_loop:
		    li $v0, 4
			la $a0, nl
			syscall
			
			li $v0, 1
			move $a0 , $a1
			syscall
			
			li $v0, 4
			la $a0, keyn_out
			syscall
		exit_cond :
		la $a0 , arr1
		la $a1 , arr2
		la $a2 , diff_indices
jr $ra
















