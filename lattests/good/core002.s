.data
str0: .string "foo"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	call fun_foo
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $str0
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

