.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	neg %eax
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

