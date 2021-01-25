.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push $-1
	push $1
	call fun_f
	add $8, %esp
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .LFalse_block10

.block8:
	movl 12(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .LFalse_block10

.LTrue_block9:
	movl $1, %eax
	movl %eax, -4(%ebp)
	jmp .block11

.LFalse_block10:
	movl $0, %eax
	movl %eax, -4(%ebp)

.block11:
	movl -4(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block5

.block4:
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jge .LFalse_block14

.block12:
	movl 12(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jge .LFalse_block14

.LTrue_block13:
	movl $1, %eax
	movl %eax, -8(%ebp)
	jmp .block15

.LFalse_block14:
	movl $0, %eax
	movl %eax, -8(%ebp)

.block15:
	movl -8(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block5

.LFalse_block6:
	movl $0, %eax
	movl %eax, -12(%ebp)
	jmp .block7

.LTrue_block5:
	movl $1, %eax
	movl %eax, -12(%ebp)

.block7:
	movl -12(%ebp), %eax
	cmpl $1, %eax
	jne .else_body_block2

.if_body_block1:
	movl $7,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block2:
	movl $42,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block3:
	push $str0
	call fun_runTimeError
	add $4, %esp

