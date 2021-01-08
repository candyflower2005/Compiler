.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jne after_cond_block1

if_body_block0:
	movl $42, %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printInt
	add $4, %esp

after_cond_block1:
	movl $0, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

