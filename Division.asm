# declarations
	 .data 
program: .asciiz "\nThis program will compute a division. Enter dividend 0 to stop the program. \n"
prompt1: .asciiz "Insert the dividend: \n"
prompt2: .asciiz "Insert the divisor: "
output1: .asciiz "The dividend is "
output2: .asciiz ", the divisor is "
output3: .asciiz ", the quotient is "
output4: .asciiz ", and the reminder is "
exitoutput: .asciiz "The divisor cannot be 0. Program terminated. "
exitoutput2: .asciiz "The dividend is 0. Therefore, quotient is zero. Program terminated. "

.text
main: 
	li $v0, 4
	la $a0, program					#Indicating the user what the program does.
	syscall 
	
	li $v0, 4
	la $a0, prompt1					#output: Asking the user to enter the dividend
	syscall
	
	li $v0, 5
	syscall						#input: storing the value into $s0
	move $s0, $v0
	
	
	li $v0, 4 
	la $a0, prompt2					#prompt2: Insert the divisor:
	syscall
	
	li $v0, 5					#input: storing the value into $s1
	syscall
	move $s1, $v0
	
	beqz $s0, target2
	beqz $s1, target1				# This condition will make that program do not break when divisor is zero EXCEPTION!!!!!!
	
	div $t1,$s0,$s1					# making the division
	mflo $t2	#quotient
	mfhi $t3	#reminder
	
	li $v0, 4					#string to show the dividend 
	la $a0, output1			
	syscall
	
	li $v0, 1
	la $a0, ($s0)					# dividend value entered
	syscall
	
	li $v0, 4					#string to show the divisor
	la $a0, output2			
	syscall
	
	bnez $s1, for
	
	
for:	
	
	li $v0, 1
	la $a0, ($s1)					#divisor value entered
	syscall
	
	li $v0, 4					#string to show the quotient 
	la $a0, output3			
	syscall
	
	li $v0, 1
	la $a0, ($t2)					#showing the quotient obtained from the division
	syscall
	
	li $v0, 4					#string to show the reminder 
	la $a0, output4			
	syscall
	
	li $v0, 1
	la $a0, ($t3)					#showing the reminder obtained from the division
	syscall
	
	bnez $s1, main
	
target1: 
	li $v0, 4
	la $a0, exitoutput				#This is when divisor is zero
	syscall 
	li $v0, 10
	syscall
	
target2: 
	li $v0, 4
	la $a0, exitoutput2				#This is when dividend is zero
	syscall 
	
	li $v0, 10
	syscall
