.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp

.if_body_block0:
	push $1
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block1:
	push $str0
	call fun_runTimeError
	add $4, %esp

