.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	call fun_p
	push $1
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_p:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

