.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	push $1
	call fun_printInt
	add $4, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl $1, %eax
	movl %eax, -8(%ebp)

.loop_cond_block0:
	movl -4(%ebp), %eax
	movl $5000000, %ebx
	cmpl %ebx, %eax
	jge .after_loop_block2

.loop_body_block1:
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl -4(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl -8(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -8(%ebp)
	jmp .loop_cond_block0

.after_loop_block2:
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

