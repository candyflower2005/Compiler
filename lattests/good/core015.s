.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push $17
	call fun_ev
	add $4, %esp
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_ev:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .else_body_block2

.if_body_block1:
	movl 8(%ebp), %eax
	movl $2, %ebx
	sub %ebx, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_ev
	add $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block2:
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jge .else_body_block6

.if_body_block5:
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block6:
	movl $1,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block3:
	push $str0
	call fun_runTimeError
	add $4, %esp

