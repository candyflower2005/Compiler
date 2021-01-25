.data
str1: .string "good"
str0: .string "bad"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $str0
	call fun_f
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $str1
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

