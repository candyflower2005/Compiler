.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_foo
	add $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -12(%ebp)
	movl $0, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	push $str0
	call fun_runTimeError
	add $4, %esp

