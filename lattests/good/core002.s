.data
str0: .string "foo"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	call fun_foo
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $str0, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

