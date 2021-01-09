.data
zeroDivMsg: .string "can't divide by 0"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $24, %esp

block0:
	movl $42, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	neg %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	neg %eax
	movl %eax, -16(%ebp)
	movl -8(%ebp), %eax
	movl -16(%ebp), %ebx
	cmp $0, %ebx
	jne after_div_0
	push $zeroDivMsg
	call fun_runTimeError

after_div_0:
	cdq
	idiv %ebx
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_printInt
	add $4, %esp

block1:
	movl $0, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

