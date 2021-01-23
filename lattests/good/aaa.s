.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $3, %eax
	movl %eax, -4(%ebp)
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -12(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

