.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $17, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_ev
	add $4, %esp
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_ev:
	push %ebp
	movl %esp, %ebp
	subl $40, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jle else_body_block2

if_body_block1:
	movl 8(%ebp), %eax
	movl %eax, -12(%ebp)
	movl $2, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl -16(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_ev
	add $4, %esp
	movl %eax, -24(%ebp)
	movl -24(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block2:
	movl 8(%ebp), %eax
	movl %eax, -28(%ebp)
	movl $0, %eax
	movl %eax, -32(%ebp)
	movl -28(%ebp), %eax
	movl -32(%ebp), %ebx
	cmpl %ebx, %eax
	jge else_body_block6

if_body_block5:
	movl $0, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block6:
	movl $1, %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block3:
	push $str0
	call fun_runTimeError
	add $4, %esp

