.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	cmp $1, %eax
	jne after_cond_block1

if_body_block0:
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block1:
	push $str0
	call fun_runTimeError
	add $4, %esp

