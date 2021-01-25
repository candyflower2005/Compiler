.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $17, %eax
	movl %eax, -4(%ebp)

.loop_cond_block0:
	movl -4(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .after_loop_block2

.loop_body_block1:
	movl -4(%ebp), %eax
	movl $2, %ebx
	sub %ebx, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -4(%ebp)
	jmp .loop_cond_block0

.after_loop_block2:
	movl -4(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jge .else_body_block4

.if_body_block3:
	push $0
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block4:
	push $1
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block5:
	push $str0
	call fun_runTimeError
	add $4, %esp

