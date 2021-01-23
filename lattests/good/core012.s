.data
str4: .string "false"
str2: .string "concatenation"
str1: .string " "
str3: .string "true"
zeroDivMsg: .string "can't divide by 0"
str0: .string "string"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $160, %esp
	movl $56, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $23, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	neg %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -24(%ebp), %eax
	movl -28(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -32(%ebp)
	push -32(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl %eax, -36(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -36(%ebp), %eax
	movl -40(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -44(%ebp)
	push -44(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl %eax, -48(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -52(%ebp)
	movl -48(%ebp), %eax
	movl -52(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -56(%ebp)
	push -56(%ebp)
	call fun_printInt
	add $4, %esp
	movl $45, %eax
	movl %eax, -60(%ebp)
	movl $2, %eax
	movl %eax, -64(%ebp)
	movl -60(%ebp), %eax
	movl -64(%ebp), %ebx
	cmp $0, %ebx
	jne after_div_0
	push $zeroDivMsg
	call fun_runTimeError

after_div_0:
	cdq
	idiv %ebx
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_printInt
	add $4, %esp
	movl $78, %eax
	movl %eax, -72(%ebp)
	movl $3, %eax
	movl %eax, -76(%ebp)
	movl -72(%ebp), %eax
	movl -76(%ebp), %ebx
	cdq
	idiv %ebx
	movl %edx, %eax
	movl %eax, -80(%ebp)
	push -80(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl %eax, -84(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -88(%ebp)
	movl -84(%ebp), %eax
	movl -88(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -92(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -96(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -100(%ebp)
	movl -96(%ebp), %eax
	movl -100(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -104(%ebp)
	movl -92(%ebp), %eax
	movl -104(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setg %cl
	mov %ecx, %eax
	movl %eax, -108(%ebp)
	push -108(%ebp)
	call fun_printBool
	add $4, %esp
	movl -8(%ebp), %eax
	movl %eax, -112(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -116(%ebp)
	movl -112(%ebp), %eax
	movl -116(%ebp), %ebx
	cmp $0, %ebx
	jne after_div_1
	push $zeroDivMsg
	call fun_runTimeError

after_div_1:
	cdq
	idiv %ebx
	movl %eax, -120(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -124(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -128(%ebp)
	movl -124(%ebp), %eax
	movl -128(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -132(%ebp)
	movl -120(%ebp), %eax
	movl -132(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setle %cl
	mov %ecx, %eax
	movl %eax, -136(%ebp)
	push -136(%ebp)
	call fun_printBool
	add $4, %esp
	movl $str0, %eax
	movl %eax, -140(%ebp)
	movl $str1, %eax
	movl %eax, -144(%ebp)
	movl -140(%ebp), %eax
	movl -144(%ebp), %ebx
	push %ebx
	push %eax
	call fun_concatStrings
	add $8, %esp
	movl %eax, -148(%ebp)
	movl $str2, %eax
	movl %eax, -152(%ebp)
	movl -148(%ebp), %eax
	movl -152(%ebp), %ebx
	push %ebx
	push %eax
	call fun_concatStrings
	add $8, %esp
	movl %eax, -156(%ebp)
	push -156(%ebp)
	call fun_printString
	add $4, %esp
	movl $0, %eax
	movl %eax, -160(%ebp)
	movl -160(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	cmp $1, %eax
	jne else_body_block2

if_body_block1:
	movl $str3, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block2:
	movl $str4, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block3:
	movl  %ebp, %esp
	pop %ebp
	ret

