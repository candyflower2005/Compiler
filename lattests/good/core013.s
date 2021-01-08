.data
str4: .string "true"
str2: .string "!"
str3: .string "false"
str0: .string "&&"
str1: .string "||"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $208, %esp
	movl $str0, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	negl %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -16(%ebp)
	movl $0, %eax
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -24(%ebp)
	movl -16(%ebp), %eax
	movl -24(%ebp), %ebx
	andl %ebx, %eax
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_printBool
	add $4, %esp
	movl $2, %eax
	movl %eax, -32(%ebp)
	movl -32(%ebp), %eax
	negl %eax
	movl %eax, -36(%ebp)
	push -36(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -40(%ebp)
	movl $1, %eax
	movl %eax, -44(%ebp)
	push -44(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -48(%ebp)
	movl -40(%ebp), %eax
	movl -48(%ebp), %ebx
	andl %ebx, %eax
	movl %eax, -52(%ebp)
	push -52(%ebp)
	call fun_printBool
	add $4, %esp
	movl $3, %eax
	movl %eax, -56(%ebp)
	push -56(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -60(%ebp)
	movl $5, %eax
	movl %eax, -64(%ebp)
	movl -64(%ebp), %eax
	negl %eax
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -72(%ebp)
	movl -60(%ebp), %eax
	movl -72(%ebp), %ebx
	andl %ebx, %eax
	movl %eax, -76(%ebp)
	push -76(%ebp)
	call fun_printBool
	add $4, %esp
	movl $234234, %eax
	movl %eax, -80(%ebp)
	push -80(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -84(%ebp)
	movl $21321, %eax
	movl %eax, -88(%ebp)
	push -88(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -92(%ebp)
	movl -84(%ebp), %eax
	movl -92(%ebp), %ebx
	andl %ebx, %eax
	movl %eax, -96(%ebp)
	push -96(%ebp)
	call fun_printBool
	add $4, %esp
	movl $str1, %eax
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_printString
	add $4, %esp
	movl $1, %eax
	movl %eax, -104(%ebp)
	movl -104(%ebp), %eax
	negl %eax
	movl %eax, -108(%ebp)
	push -108(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -112(%ebp)
	movl $0, %eax
	movl %eax, -116(%ebp)
	push -116(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -120(%ebp)
	movl -112(%ebp), %eax
	movl -120(%ebp), %ebx
	orl %ebx, %eax
	movl %eax, -124(%ebp)
	push -124(%ebp)
	call fun_printBool
	add $4, %esp
	movl $2, %eax
	movl %eax, -128(%ebp)
	movl -128(%ebp), %eax
	negl %eax
	movl %eax, -132(%ebp)
	push -132(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -136(%ebp)
	movl $1, %eax
	movl %eax, -140(%ebp)
	push -140(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -144(%ebp)
	movl -136(%ebp), %eax
	movl -144(%ebp), %ebx
	orl %ebx, %eax
	movl %eax, -148(%ebp)
	push -148(%ebp)
	call fun_printBool
	add $4, %esp
	movl $3, %eax
	movl %eax, -152(%ebp)
	push -152(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -156(%ebp)
	movl $5, %eax
	movl %eax, -160(%ebp)
	movl -160(%ebp), %eax
	negl %eax
	movl %eax, -164(%ebp)
	push -164(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -168(%ebp)
	movl -156(%ebp), %eax
	movl -168(%ebp), %ebx
	orl %ebx, %eax
	movl %eax, -172(%ebp)
	push -172(%ebp)
	call fun_printBool
	add $4, %esp
	movl $234234, %eax
	movl %eax, -176(%ebp)
	push -176(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -180(%ebp)
	movl $21321, %eax
	movl %eax, -184(%ebp)
	push -184(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -188(%ebp)
	movl -180(%ebp), %eax
	movl -188(%ebp), %ebx
	orl %ebx, %eax
	movl %eax, -192(%ebp)
	push -192(%ebp)
	call fun_printBool
	add $4, %esp
	movl $str2, %eax
	movl %eax, -196(%ebp)
	push -196(%ebp)
	call fun_printString
	add $4, %esp
	movl $1, %eax
	movl %eax, -200(%ebp)
	push -200(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -204(%ebp)
	push -204(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -208(%ebp)
	movl -208(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	cmp $0, %eax
	jne else_body_block2

if_body_block1:
	movl $str3, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printString
	add $4, %esp
	jmp after_cond_block3

else_body_block2:
	movl $str4, %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block3:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_test:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl -12(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setg %cl
	mov %ecx, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

