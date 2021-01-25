.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp

.block0:
	push $42
	call fun_printInt
	add $4, %esp

.block1:
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

