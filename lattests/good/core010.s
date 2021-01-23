.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $5, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_fac
	add $4, %esp
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_fac:
	push %ebp
	movl %esp, %ebp
	subl $44, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -20(%ebp)

loop_cond_block1:
	movl $0, %eax
	movl %eax, -24(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -32(%ebp)
	movl -20(%ebp), %eax
	movl -24(%ebp), %ebx
	cmpl %ebx, %eax
	jle after_loop_block3

loop_body_block2:
	movl -16(%ebp), %eax
	movl -20(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -36(%ebp)
	movl $1, %eax
	movl %eax, -40(%ebp)
	movl -20(%ebp), %eax
	movl -40(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -44(%ebp)
	movl -36(%ebp), %eax
	movl %eax, -16(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -36(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -32(%ebp)
	jmp loop_cond_block1

after_loop_block3:
	movl -28(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

