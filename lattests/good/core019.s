.data
str0: .string "foo"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp

.block0:
	push $1
	call fun_printInt
	add $4, %esp

.block1:
	push $78
	call fun_printInt
	add $4, %esp
	movl $78, %eax
	movl %eax, -4(%ebp)

.loop_cond_block2:
	movl -4(%ebp), %eax
	movl $76, %ebx
	cmpl %ebx, %eax
	jle .after_loop_block4

.loop_body_block3:
	movl -4(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl $7, %ebx
	add %ebx, %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl %eax, -4(%ebp)
	jmp .loop_cond_block2

.after_loop_block4:
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl -4(%ebp), %eax
	movl $4, %ebx
	cmpl %ebx, %eax
	jle .else_body_block6

.if_body_block5:
	push $4
	call fun_printInt
	add $4, %esp
	jmp .after_cond_block7

.else_body_block6:
	push $str0
	call fun_printString
	add $4, %esp

.after_cond_block7:
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

