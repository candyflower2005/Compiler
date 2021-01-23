.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $36, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $56, %eax
	movl %eax, -8(%ebp)
	movl $45, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl -12(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -16(%ebp)
	movl $2, %eax
	movl %eax, -20(%ebp)
	movl -16(%ebp), %eax
	movl -20(%ebp), %ebx
	cmpl %ebx, %eax
	jg else_body_block1

if_body_block0:
	movl $1, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -28(%ebp)
	jmp after_cond_block2

else_body_block1:
	movl $2, %eax
	movl %eax, -32(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -28(%ebp)

after_cond_block2:
	push -28(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

