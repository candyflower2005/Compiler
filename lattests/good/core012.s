.data
str2: .string "false"
str0: .string "string concatenation"
str1: .string "true"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $33
	call fun_printInt
	add $4, %esp
	push $79
	call fun_printInt
	add $4, %esp
	push $-1288
	call fun_printInt
	add $4, %esp
	push $22
	call fun_printInt
	add $4, %esp
	push $0
	call fun_printInt
	add $4, %esp
	push $1
	call fun_printBool
	add $4, %esp
	push $0
	call fun_printBool
	add $4, %esp
	push $str0
	call fun_printString
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl 8(%ebp), %eax
	cmpl $1, %eax
	jne .else_body_block2

.if_body_block1:
	push $str1
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block2:
	push $str2
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block3:
	movl  %ebp, %esp
	pop %ebp
	ret

