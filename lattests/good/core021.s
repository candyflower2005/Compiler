.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $1, %eax
	cmp $1, %eax
	jne after_cond_block1

if_body_block0:
	movl $1, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block1:
	push $str0
	call fun_runTimeError
	add $4, %esp

