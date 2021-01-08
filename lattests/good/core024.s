.data
str1: .string "NOOO"
str0: .string "yes"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl $2, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	push -4(%ebp)
	call fun_f
	add $8, %esp
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $28, %esp
	movl 12(%ebp), %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jg LTrue_block4

block3:
	call fun_e
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block4

LFalse_block5:
	movl $0, %eax
	movl %eax, -16(%ebp)
	movl %eax, -20(%ebp)
	jmp block6

LTrue_block4:
	movl $1, %eax
	movl %eax, -24(%ebp)
	movl %eax, -20(%ebp)

block6:
	movl -20(%ebp), %eax
	cmpl $1, %eax
	jne after_cond_block2

if_body_block1:
	movl $str0, %eax
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block2:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_e:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $str1, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

