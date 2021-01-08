.data
str2: .string "false"
str0: .string "apa"
str1: .string "true"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $192, %esp
	movl $4, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $3, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl -16(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setle %cl
	mov %ecx, %eax
	movl %eax, -20(%ebp)
	movl $4, %eax
	movl %eax, -24(%ebp)
	movl $2, %eax
	movl %eax, -28(%ebp)
	movl -24(%ebp), %eax
	movl -28(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setne %cl
	mov %ecx, %eax
	movl %eax, -32(%ebp)
	movl $1, %eax
	movl %eax, -36(%ebp)
	movl -32(%ebp), %eax
	movl -36(%ebp), %ebx
	and %ebx, %eax
	movl %eax, -40(%ebp)
	movl -20(%ebp), %eax
	movl -40(%ebp), %ebx
	andl %ebx, %eax
	cmpl $1, %eax
	jne else_body_block1
	cmpl %ebx, %eax

if_body_block0:
	movl $1, %eax
	movl %eax, -44(%ebp)
	push -44(%ebp)
	call fun_printBool
	add $4, %esp
	jmp after_cond_block2

else_body_block1:
	movl $str0, %eax
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block2:
	movl $1, %eax
	movl %eax, -52(%ebp)
	movl $1, %eax
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	movl -56(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	sete %cl
	mov %ecx, %eax
	movl %eax, -60(%ebp)
	movl $1, %eax
	movl %eax, -64(%ebp)
	push -64(%ebp)
	call fun_dontCallMe
	add $4, %esp
	movl %eax, -68(%ebp)
	movl -60(%ebp), %eax
	movl -68(%ebp), %ebx
	or %ebx, %eax
	movl %eax, -72(%ebp)
	push -72(%ebp)
	call fun_printBool
	add $4, %esp
	movl $4, %eax
	movl %eax, -76(%ebp)
	movl $5, %eax
	movl %eax, -80(%ebp)
	movl -80(%ebp), %eax
	neg %eax
	movl %eax, -84(%ebp)
	movl -76(%ebp), %eax
	movl -84(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setl %cl
	mov %ecx, %eax
	movl %eax, -88(%ebp)
	movl $2, %eax
	movl %eax, -92(%ebp)
	push -92(%ebp)
	call fun_dontCallMe
	add $4, %esp
	movl %eax, -96(%ebp)
	movl -88(%ebp), %eax
	movl -96(%ebp), %ebx
	and %ebx, %eax
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_printBool
	add $4, %esp
	movl $4, %eax
	movl %eax, -104(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -108(%ebp)
	movl -104(%ebp), %eax
	movl -108(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	sete %cl
	mov %ecx, %eax
	movl %eax, -112(%ebp)
	movl $1, %eax
	movl %eax, -116(%ebp)
	movl $0, %eax
	movl %eax, -120(%ebp)
	movl -120(%ebp), %eax
	xor $1, %eax
	movl %eax, -124(%ebp)
	movl -116(%ebp), %eax
	movl -124(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	sete %cl
	mov %ecx, %eax
	movl %eax, -128(%ebp)
	movl $1, %eax
	movl %eax, -132(%ebp)
	movl -128(%ebp), %eax
	movl -132(%ebp), %ebx
	and %ebx, %eax
	movl %eax, -136(%ebp)
	movl -112(%ebp), %eax
	movl -136(%ebp), %ebx
	and %ebx, %eax
	movl %eax, -140(%ebp)
	push -140(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -144(%ebp)
	movl $0, %eax
	movl %eax, -148(%ebp)
	push -148(%ebp)
	push -144(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -152(%ebp)
	push -152(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -156(%ebp)
	movl $1, %eax
	movl %eax, -160(%ebp)
	push -160(%ebp)
	push -156(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -164(%ebp)
	push -164(%ebp)
	call fun_printBool
	add $4, %esp
	movl $1, %eax
	movl %eax, -168(%ebp)
	movl $0, %eax
	movl %eax, -172(%ebp)
	push -172(%ebp)
	push -168(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -176(%ebp)
	push -176(%ebp)
	call fun_printBool
	add $4, %esp
	movl $1, %eax
	movl %eax, -180(%ebp)
	movl $1, %eax
	movl %eax, -184(%ebp)
	push -184(%ebp)
	push -180(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -188(%ebp)
	push -188(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -192(%ebp)
	movl -192(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_dontCallMe:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	cmp $1, %eax
	jne else_body_block6

if_body_block5:
	movl $str1, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	jmp after_cond_block7

else_body_block6:
	movl $str2, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block7:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_implies:
	push %ebp
	movl %esp, %ebp
	subl $24, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	xor $1, %eax
	movl %eax, -8(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -12(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl -16(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	sete %cl
	mov %ecx, %eax
	movl %eax, -20(%ebp)
	movl -8(%ebp), %eax
	movl -20(%ebp), %ebx
	or %ebx, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

