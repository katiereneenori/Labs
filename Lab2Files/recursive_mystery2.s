# Exercise 3
# Max Score: 12 points
#
# Students: 
# Tanner Shartel and Katie Dionne (50/50 effort)
#
.data	
list1:		.word		3, 9, -1, 0, 6, 5, -4, -7, -8,  
list2:		.word		9, 5, 0, 3, -4, 5, 6, -7, 8, 9, 
.text
.globl	tomato
tomato: 
addi	$sp, $sp, -8       
addi	$t0, $a0, -1       
sw  	$t0, 0($sp)        
sw  	$ra, 4($sp)        
bne 	$a0, $zero, orange   
li  	$v0, 0             
addi	$sp, $sp, 8        
jr 	$ra                  

orange:   
add  $a0, $0, $t0            
jal   tomato 
lw    $t0, 0($sp)  
sll	$t1, $t0, 2  
add   $t1, $t1, $a1     
lw    $t2, 0($t1)
slt   $t3, $t2, $a2
bne   $t3, $0, carrot      
add   $v0, $v0, $t2 

carrot:    
lw    $ra, 4($sp)                
addi 	$sp, $sp, 8        
jr 	$ra                      
########################################################################
.globl	test
test:	
addi	$sp, $sp, -4		# Make space on stack
sw	$ra, 0($sp)		# Save return address
jal	tomato			# call function
lw	$ra, 0($sp)		# Restore return address
addi	$sp, $sp, 4		# Restore stack pointer
jr 	$ra			# Return
########################################################################
# main function starts here                                            #
.globl main
main:	addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)	# Save return address
	la	$a1, list2	#loads the base address of list2 into $a1
	li	$a0, 8          #set $a0 = 8
        li      $a2, 5		#set $a2 = 5
	jal	test		#jump 
#
# after test v0 now contains sum of elements from list2 **fix**
# if they are >= 5 up to the 8th element
# 9 + 5 + 5 + 6 = 25
# What is the value of $v0 at this point? (v0)= _ _ _ _ 25 _ _ _ _ #
#
	la	$a1, list1	# load base address of list1 to $a1
	li	$a0, 13		#set $a0 = 13
	jal	test		#jump
#
# v0 after test contains the sum of elements in list1
# if they are >=5 up to the 13th element at index 12
# this is 9(at i0) 6(at i4) and 5(at i5)
# 9 + 6 + 5 + 9 + 5 = 34
# What is the value of $v0 at this point? (v0) = _ _ _ _ 34 _ _ _ _ #
#
# What does this code compute? Your answer HERE:_ _ _ see below _ _ #
# this code computers the sum of elements in an array that are 
# greater than or equal to the threshold($a2) 
# up to specified($a0) number of elements
#
return:	
	li	$v0, 0			# Return value
	lw	$ra, 0($sp)		# Restore return address
	addi	$sp, $sp, 4		# Restore stack pointer
	jr 	$ra			# Return	
