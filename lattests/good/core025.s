.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $20, %esp
	movl $2, %eax
	movl %eax, -4(%ebp)
	movl $2, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	neg %eax
	movl %eax, -12(%ebp)
	movl -4(%ebp), %eax
	movl -12(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -16(%ebp)
	push -16(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

