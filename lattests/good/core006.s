.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $40, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl $45, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl $36, %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	neg %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -32(%ebp)
	push -32(%ebp)
	call fun_printInt
	add $4, %esp
	movl -28(%ebp), %eax
	movl %eax, -36(%ebp)
	push -36(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

