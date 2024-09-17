# Exercise 3
# Max Score: 12 points
.data	
list1:		.word		3, 9, 1, 2, 6, 3, -4, -7, -8, 4, -2,  8, 7, 6
.text 		# list1 is an array of integers storing the given sequence of values	 
.globl	tomato

tomato: 
addi	$sp, $sp, -8		# make space on stack
addi	$t0, $a0, -1		# store decremented a0 value in t0 temp reg
sw  	$t0, 0($sp)			# store t0 on stack, recursing through the list1 length
sw  	$ra, 4($sp)			# store ra on stack
bne 	$a0, $zero, orange  # check if a0 == 0 to see if it has reached the end
li  	$v0, 0             	
addi	$sp, $sp, 8        
jr 	$ra                  

orange:   
move  $a0, $t0			# new argument is the temp value in t0
jal   	tomato 
lw    	$t0, 0($sp)  
sll	$t1, $t0, 2  
add   	$t1, $t1, $a1     
lw    	$t2, 0($t1)       
add   	$v0, $v0, $t2     
lw    	$ra, 4($sp)                
addi 	$sp, $sp, 8        
jr 	$ra                  

# main function starts here                                            						
.globl main
main:	
    addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)			# Save return address
	la	$a1, list1			# a1 has the base address pointing to the first 
							# element of the “list1” array declared in .data section 
							# above
	li	$a0, 9				# loads the immediate value into the destination register
	jal	tomato	

return:	
	li	$v0, 0				# Return value
	lw	$ra, 0($sp)			# Restore return address
	addi	$sp, $sp, 4		# Restore stack pointer
	jr 	$ra					# Return

# Step through this code in your simulator and monitor the register values. 
# What does the tomato function do?   
# Write your answer HERE_ _ _ _ _ _ _ _ _ #          
#
# Tanner Shartel and Katie Dionne (50/50 effort)      
#
# The tomato function gets the number of elements in the array from the main
# function, and loops through each one, making space on the stack, storing the 
# index for each item in the array, until there is an index, and a return address
# for each object in the array. Each time it decrements the value a0, stores in 
# the stack, and checks if it equals zero.
#
#
#