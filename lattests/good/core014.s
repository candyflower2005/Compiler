.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $104, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl $1, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -28(%ebp)
	movl $5000000, %eax
	movl %eax, -32(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -36(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -40(%ebp)
	push -40(%ebp)
	call fun_printInt
	add $4, %esp
	movl -28(%ebp), %eax
	movl %eax, -44(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -48(%ebp)

loop_cond_block0:
	movl -44(%ebp), %eax
	movl %eax, -52(%ebp)
	movl -36(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -60(%ebp)
	movl -48(%ebp), %eax
	movl %eax, -64(%ebp)
	movl -52(%ebp), %eax
	movl -56(%ebp), %ebx
	cmpl %ebx, %eax
	jge after_loop_block2

loop_body_block1:
	movl -44(%ebp), %eax
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_printInt
	add $4, %esp
	movl -48(%ebp), %eax
	movl %eax, -72(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -76(%ebp)
	movl -72(%ebp), %eax
	movl -76(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -80(%ebp)
	movl -80(%ebp), %eax
	movl %eax, -84(%ebp)
	movl -84(%ebp), %eax
	movl %eax, -88(%ebp)
	movl -48(%ebp), %eax
	movl %eax, -92(%ebp)
	movl -88(%ebp), %eax
	movl -92(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -96(%ebp)
	movl -96(%ebp), %eax
	movl %eax, -100(%ebp)
	movl -84(%ebp), %eax
	movl %eax, -44(%ebp)
	movl -100(%ebp), %eax
	movl %eax, -48(%ebp)
	movl -84(%ebp), %eax
	movl %eax, -60(%ebp)
	movl -100(%ebp), %eax
	movl %eax, -64(%ebp)
	jmp loop_cond_block0

after_loop_block2:
	movl $0, %eax
	movl %eax, -104(%ebp)
	movl -104(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

