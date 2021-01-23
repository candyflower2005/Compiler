.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $7, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

