.data
str1: .string "NOOO"
str0: .string "yes"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $2
	push $1
	call fun_f
	add $8, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 12(%ebp), %eax
	movl 8(%ebp), %ebx
	cmpl %ebx, %eax
	jg .LTrue_block4

.block3:
	call fun_e
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block4

.LFalse_block5:
	movl $0, %eax
	movl %eax, -8(%ebp)
	jmp .block6

.LTrue_block4:
	movl $1, %eax
	movl %eax, -8(%ebp)

.block6:
	movl -8(%ebp), %eax
	cmpl $1, %eax
	jne .after_cond_block2

.if_body_block1:
	push $str0
	call fun_printString
	add $4, %esp

.after_cond_block2:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_e:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $str1
	call fun_printString
	add $4, %esp
	movl $0,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

