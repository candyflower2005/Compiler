.data
str1: .string "No return in a non-void function"
str0: .string "No return in a non-void function"

.globl main

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp

.if_body_block0:
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block2:
	push $str0
	call fun_runTimeError
	add $4, %esp

fun_g:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	jmp .else_body_block5

.if_body_block4:
	jmp .after_cond_block6

.else_body_block5:
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block6:
	push $str1
	call fun_runTimeError
	add $4, %esp

fun_p:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	call fun_p
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

