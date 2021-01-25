.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp

.if_body_block0:
	push $42
	call fun_printInt
	add $4, %esp

.after_cond_block1:
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

