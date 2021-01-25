.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	jmp .else_body_block1

.if_body_block0:
	movl $1, %eax
	movl %eax, -4(%ebp)
	jmp .after_cond_block2

.else_body_block1:
	movl $2, %eax
	movl %eax, -4(%ebp)

.after_cond_block2:
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

