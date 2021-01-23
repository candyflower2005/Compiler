.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $64, %esp
	movl $17, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -12(%ebp)

loop_cond_block0:
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl $0, %eax
	movl %eax, -20(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -16(%ebp), %eax
	movl -20(%ebp), %ebx
	cmpl %ebx, %eax
	jle after_loop_block2

loop_body_block1:
	movl -12(%ebp), %eax
	movl %eax, -28(%ebp)
	movl $2, %eax
	movl %eax, -32(%ebp)
	movl -28(%ebp), %eax
	movl -32(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	movl %eax, -12(%ebp)
	movl -40(%ebp), %eax
	movl %eax, -24(%ebp)
	jmp loop_cond_block0

after_loop_block2:
	movl -24(%ebp), %eax
	movl %eax, -44(%ebp)
	movl $0, %eax
	movl %eax, -48(%ebp)
	movl -44(%ebp), %eax
	movl -48(%ebp), %ebx
	cmpl %ebx, %eax
	jge else_body_block4

if_body_block3:
	movl $0, %eax
	movl %eax, -52(%ebp)
	push -52(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -56(%ebp)
	movl -56(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block4:
	movl $1, %eax
	movl %eax, -60(%ebp)
	push -60(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -64(%ebp)
	movl -64(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block5:
	push $str0
	call fun_runTimeError
	add $4, %esp

