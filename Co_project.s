.data
	list: 				.space 60 																			#int arr[15]
	list_number: 		.space 4 																			#int list_number
	menu_number: 		.space 4 																			#int menu_number
	message: 			.asciiz "\n you have exceed the array size \n"										#char message[50]="you have exceed the array size"
	max_result: 		.asciiz "\n Maximum number = "														#char max_result[25]="Maximum number ="
	min_result: 		.asciiz "\n Minimum number = "														#char min_result[25]="Minimum number ="
	element_of_list: 	.asciiz "Enter element of the list\n"												#char element_of_list[30]="Enter element of the list"
	List_size: 			.asciiz "List size: "																#char List_size[20]="List size: "
	menu_message: 		.asciiz "\n choice case: \n (1) Get Maximum. \n (2) Get Minimum. \n (3) Exit. \n"	#char menu_message[70]="choice"
	errorMessage: 		.asciiz "\n Error! selection is not correct\n"										#char errorMessage[50]="Error"
	endMessage: 		.asciiz "\n Try us again. \n"														#char endMessage[15]="Try us again."
	arrayError: 		.asciiz "\n you have exceed the array size \n"										#char arrayError[50]="you have exceed the array size."
	
.text

main:
#calls for functions

	jal number_of_elements  		#function to scan the array numbers. 					done by @ Mahmoud Hussein'
	
	lw $t1, list_number   			#list_number to $t1
	slt $s6, $t1, 16				#if list_number < 16
	beq $s6, $zero, Else           	#if false go to else
	
	jal scan_array					#function to scan the array.				 			done by @ Mahmoud Amin
	jal sort						#function to sort the array.				 			done by @ karem khamiss
	jal menu_display				#function to display the menu to user.				 	done by @ Saad Tarek

	j Endif							#go to Endif
	
Else:
	li $v0 , 4             			# to print string 
	la $a0 , arrayError     		# printing arrayError message to screen 
	syscall

Endif:
	
	jal exitProgram
	
#function number of elements
number_of_elements:
	li $v0 , 4             			# to print string 
	la $a0 , List_size     			# printing scan_message to screen 
	syscall
	
	li $v0 , 5              		# read integer number as input
	syscall
 
	sw $v0, list_number     		# store value which is read to variable list_number
	
    jr $ra	            			# return to main program

#function scan array	
scan_array:
	addi $t0, $zero, 0 				#Writting Array Location
    addi $t3, $zero, 0 				#Printing Array Location
    la $s0, list

	lw $s1, list_number 			# assume global symbol
	sub $s1, $s1, 1
	
	#Prompt user for a value
    la $v0, 4
    la $a0, element_of_list
	syscall
	
    loop:
        
        #Store the value into T1
        add $v0, $zero, 5
        syscall
        add $t1, $v0, $zero

        #Store the contents of T1 into the array
        sll $t2, $t0, 2
        add $t2, $t2, $s0
		sw $t1, ($t2)
		
        beq $t0, $s1, endLoop 		#After element_of_list entries, we want to export the list
        addi $t0, $t0, 1 			#If it's not at element_of_list entries, we want to loop this section
		j loop
		
	endLoop:
        jr $ra	            		# return to main program

#function sort array
sort:
	la  $t0, list      				# Copy the base address of your array into $t1
    add $t0, $t0, 40   		 		# 4 bytes per int * 10 ints = 40 bytes          
	
outterLoop:             			# Used to determine when we are done iterating over the Array
    add $t1, $0, $0    			 	# $t1 holds a flag to determine when the list is sorted
    la  $a0, list      				# Set $a0 to the base address of the Array
	
innerLoop:              		    # The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($a0)     		    # sets $t2 to the current element in array
    lw  $t3, 4($a0)     		    # sets $t3 to the next element in array
    slt $t5, $t2, $t3   		    # $t5 = 1 if $t2 < $t3
    beq $t5, $0, continue   		# if $t5 = 1, then swap them
    add $t1, $0, 1         		 	# if we need to swap, we need to check the list again
    sw  $t2, 4($a0)         		# store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($a0)         		# store the lesser numbers contents in the lower position in array (swap)
	
continue:
    addi $a0, $a0, 4            	# advance the array to start at the next location from last time
    bne  $a0, $t0, innerLoop    	# If $a0 != the end of Array, jump back to innerLoop
    bne  $t1, $0, outterLoop    	# $t1 = 1, another pass is needed, jump back to outterLoop

	jr $ra	            			# return to main program
	
#function menu_display	
menu_display:

    while:
		
		# Print Menu Options
        li $v0, 4
		la $a0, menu_message
        syscall
		
        # Scan User Sellection
		
		li $v0, 5
        syscall
        move $t0, $v0

        beq $t0,1, max_fun			#function to get the maximum of the array.				 	done by @ Mahmoud saad
        beq $t0,2, min_fun			#function to get the maximum of the array.				 	done by @ Ayman Amer
		beq $t0,3, Exit   			#check if reach end of array
        
		li $v0, 4
        la $a0, errorMessage
        syscall

        j while          			#jump to while loop 

    Exit: #end of loop
      li $v0, 4
      la $a0, endMessage
      syscall

    jr $ra

#function max function
min_fun:
	la	$a0, max_result             # string to $a0
	li	$v0, 4                		# op code to v0 print string
	syscall                 		# print
	
	la $t0, list		            # list to $t0
	lw $t1, list_number   			# list_number to $t1
	li $t6,1						# 1 to t6
	sub $t2 ,$t1 ,$t6				# list_number-1 to t2
	add $t2,$t2,$t2					#$t2 *2
	add $t2,$t2,$t2					#$t2 *2 ($t2 *4)
	add $t5 ,$t2,$t0				# address of list[list_number-1]
    lw $t4, 0($t5)       			#  list[list_number-1] to t4
	move $a0,$t4					#  t4 to a0
	li $v0, 1               		# print int op code
	syscall                 		# print
	j while							# return

#function min function
max_fun:
	la	$a0, min_result             # string to $a0
	li	$v0, 4                		# op code to v0 print string
	syscall                 		# print
	
	la $a3, list            		# list to $a3
	lw $a0,0($a3)        			#access 1st element of word array or array[0]
	li $v0, 1               		# print int op code
	syscall                 		# print
	j while							# return
	
#function to terminate the program
exitProgram:
	li $v0,10 						#the program is done
	syscall
