.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $45
	call fun_printInt
	add $4, %esp
	push $-36
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

