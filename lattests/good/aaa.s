.data
str1: .string "afasfas!@412"
str0: .string "fasfa"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl $5, %ebx
	cmpl %ebx, %eax
	jle .else_body_block2

.if_body_block1:
	movl $5, %eax
	movl %eax, -4(%ebp)
	jmp .after_cond_block3

.else_body_block2:
	movl $6, %eax
	movl %eax, -4(%ebp)

.after_cond_block3:
	movl -4(%ebp), %eax
	movl $3, %ebx
	add %ebx, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl $4, %ebx
	add %ebx, %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	push $str0
	call fun_printString
	add $4, %esp
	push $str1
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

