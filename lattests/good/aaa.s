.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $10
	call fun_foo
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $60, %esp
	movl 8(%ebp), %eax
	movl $1, %ebx
	add %ebx, %eax
	movl %eax, -4(%ebp)
	movl $2, %eax
	movl -4(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl $4, %ebx
	sub %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl $5, %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setg %cl
	mov %ecx, %eax
	movl %eax, -16(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -20(%ebp)

.loop_cond_block1:
	movl -20(%ebp), %eax
	movl $0, %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setle %cl
	mov %ecx, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	cmp $0, %eax
	jne .after_loop_block3

.loop_body_block2:
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	movl -20(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -28(%ebp)
	movl -28(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .else_body_block5

.if_body_block4:
	movl -28(%ebp), %eax
	movl %eax, -32(%ebp)
	jmp .after_cond_block6

.else_body_block5:
	movl -28(%ebp), %eax
	movl %eax, -36(%ebp)

.loop_cond_block7:
	movl -36(%ebp), %eax
	movl $2, %ebx
	cdq
	idiv %ebx
	movl %edx, %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jne .after_loop_block9

.loop_body_block8:
	movl -36(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -44(%ebp)
	movl $20, %eax
	movl -4(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_printInt
	add $4, %esp
	movl -44(%ebp), %eax
	movl %eax, -36(%ebp)
	jmp .loop_cond_block7

.after_loop_block9:
	movl -36(%ebp), %eax
	movl %eax, -32(%ebp)

.after_cond_block6:
	movl -32(%ebp), %eax
	movl %eax, -20(%ebp)
	jmp .loop_cond_block1

.after_loop_block3:
	movl -16(%ebp), %eax
	cmpl $1, %eax
	jne .after_cond_block11

.if_body_block10:
	movl $2, %eax
	movl -20(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	movl $4, %ebx
	sub %ebx, %eax
	movl %eax, -56(%ebp)
	push -56(%ebp)
	call fun_printInt
	add $4, %esp

.after_cond_block11:
	movl $20, %eax
	movl -4(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -60(%ebp)
	push -60(%ebp)
	call fun_printInt
	add $4, %esp
	movl  %ebp, %esp
	pop %ebp
	ret

