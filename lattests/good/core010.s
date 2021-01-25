.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push $5
	call fun_fac
	add $4, %esp
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_fac:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)

.loop_cond_block1:
	movl -8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .after_loop_block3

.loop_body_block2:
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -8(%ebp)
	jmp .loop_cond_block1

.after_loop_block3:
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

