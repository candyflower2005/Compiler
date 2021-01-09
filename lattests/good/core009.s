.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	call fun_foo
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $10, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

