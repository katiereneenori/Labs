# Exercise 2
#  Max Score: 9 points
#
# Students: 
# Tanner Shartel (50% effort)
# Katie Dionne (50% effort)
#
# 'count_occurence.a' - count the occurrences of a specific character in string 
# "str". Indexed addressing is used to access the array elements.
#  MAX Score: 15 points
# Expected Outcome:- 
# The following string will be printed on the console,
# "Count is 6"
#
# Questions:-
# 1. Briefly describe the purposes of the registers, $t0, $t1, $t2, and $t3.
#
# $t0 is the temporary register that stores the value of each character from the 
# string. $t1 is the incremented index that traverses the string. $t2 stores the # number of instances of the desired character. $t3 stores the character that is 
# being counted in the string.
#
# 2. Currently, the program is stuck in an infinite loop. Make use of 
#    breakpoints to locate, and correct the error.
#
#The error is in the con: branch, in the add instruction. This instruction is 
# used to traverse the string, so it needs to increment $t1 by 1 each time it
# loops. It incorrectly added the value stored in $t2 by 1, and stored that in 
# $t1, so $t1 stayed at 1 indefinitely.
#

	.text

	.globl main

main:	

	li      $t1, 0          # initialize register $t1 to '0'
	li      $t2, 0          # initialize register $t2 to '0'
	lb      $t3, char       # initialize register $t3 to 'char'

loop:

    lb      $t0, str($t1)	# fetch a character in 'str'
	beqz    $t0, strEnd	    # if a null character is fetched, exit the loop
	bne     $t0, $t3, con   # branches to 'con' if registers $t0, and $t3 are not the same
	add     $t2, $t2, 1	    # increment register $t2

con:	

    add     $t1, $t1, 1	    # increase indexing register $t1 ERROR HERE, incorrect increment
	j       loop	       	# continues the loop

strEnd:

	la      $a0, ans        # load $a0 with the address of the string, 'ans'
	li      $v0, 4	        # trap code, '4', refers to 'print_string' system call
	syscall                 # execute the system call

	move    $a0, $t2        # move the integer to print from register $t2->$a0
	li      $v0, 1	        # trap code, '1', refers to 'print_int' system call
	syscall		            # execute the system call

	la      $a0, endl	    # load $a0 with the address of the string, 'ans'
	li      $v0, 4	        # trap code, '4', refers to 'print_string' system call
	syscall                 # execute the system call

	li      $v0, 10         # terminate the program
	syscall


	.data

str:	.asciiz "abceebceebeebbacacb"
char:	.asciiz "e"
ans:	.asciiz "Count is "
endl:	.asciiz "\n"

