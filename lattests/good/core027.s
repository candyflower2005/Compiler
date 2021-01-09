.data
str1: .string "good"
str0: .string "bad"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $str0, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_f
	add $4, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $str1, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

