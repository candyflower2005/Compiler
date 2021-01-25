.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	call fun_foo
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl $10,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

