.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push $3
	call fun_f
	add $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jge .after_cond_block2

.if_body_block1:
	movl 8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block2:
	push $str0
	call fun_runTimeError
	add $4, %esp

