.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $24, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl $45, %eax
	movl %eax, -12(%ebp)
	movl $36, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	neg %eax
	movl %eax, -20(%ebp)
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	push -20(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

