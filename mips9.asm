.data

message1: .asciiz "Provide a degree for cos(x): "
message2: .asciiz "Result is cos(x) = : "
pi: .float 3.14159265359
translator: .float 180
float: .float 1.0
start: .float 1
negation: .float -1
.text

main:
	li $v0, 4
	la $a0, message1
	syscall

	li $v0, 5
	syscall

	move $t0, $v0
	li $s0, -1
	
	beq $s0, $t0, main
	
	mtc1 $t0, $f1
	cvt.s.w $f1, $f1
	lwc1 $f2, pi
	lwc1 $f3, translator
	
	mul.s $f1, $f1, $f2
	div.s $f1, $f1, $f3
	
	mov.s $f12, $f1
	
	jal funcCosine

	li $v0, 4
	la $a0, message2
	syscall
	
	li $v0, 2
	mov.s $f0, $f12
	syscall
	
	li $v0, 10
	syscall

	funcCosine:
		
		li $t1, 0
		li $t7, 14
		li $t3, 2
		li $t2, 2
		
		lwc1 $f1, float
		lwc1 $f9, start
		lwc1 $f4, start
		lwc1 $f5, start
		lwc1 $f6, negation
	
		mul.s $f12, $f12, $f12
	Loop:
		beq $t1, $t7, Exit1
		addi $t1, $t1, 2
		
		mtc1 $t1, $f2
		cvt.s.w $f2, $f2
		
		mul.s $f1, $f1, $f2
		sub.s $f7, $f1, $f5
		mul.s $f8, $f1, $f7
		mov.s $f1, $f8
	
		mul.s $f4, $f4, $f12
		
		div $t2, $t3
		mfhi $s1
		beq $s1, $zero, Else
		bne $s1, $zero, Else
							
		div.s $f3, $f4, $f1		
		add.s $f9, $f9, $f3	
		
		addi $t2, $t2, 1
				
		j Loop
					
	Else:
		mul.s $f4, $f4, $f6
		jr $ra						
				
	Exit1:
		mov.s $f0, $f9
		jr $ra 
	
			
					