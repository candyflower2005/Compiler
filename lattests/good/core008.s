.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $36, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $7, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -12(%ebp)
	movl $1234234, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	neg %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_printInt
	add $4, %esp
	movl -12(%ebp), %eax
	movl %eax, -32(%ebp)
	push -32(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

