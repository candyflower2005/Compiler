.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $172, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $2, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl $1, %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -24(%ebp)
	movl $2, %eax
	movl %eax, -28(%ebp)
	movl -28(%ebp), %eax
	movl %eax, -32(%ebp)
	movl $1, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	movl %eax, -40(%ebp)
	movl $2, %eax
	movl %eax, -44(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -48(%ebp)
	movl $1, %eax
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	movl %eax, -56(%ebp)
	movl $2, %eax
	movl %eax, -60(%ebp)
	movl -60(%ebp), %eax
	movl %eax, -64(%ebp)
	movl $1, %eax
	movl %eax, -68(%ebp)
	movl -68(%ebp), %eax
	movl %eax, -72(%ebp)
	movl $2, %eax
	movl %eax, -76(%ebp)
	movl -76(%ebp), %eax
	movl %eax, -80(%ebp)
	movl $1, %eax
	movl %eax, -84(%ebp)
	movl -84(%ebp), %eax
	movl %eax, -88(%ebp)
	movl $2, %eax
	movl %eax, -92(%ebp)
	movl -92(%ebp), %eax
	movl %eax, -96(%ebp)
	movl $1, %eax
	movl %eax, -100(%ebp)
	movl -100(%ebp), %eax
	movl %eax, -104(%ebp)
	movl $2, %eax
	movl %eax, -108(%ebp)
	movl -108(%ebp), %eax
	movl %eax, -112(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -116(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -120(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -124(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -128(%ebp)
	movl -40(%ebp), %eax
	movl %eax, -132(%ebp)
	movl -48(%ebp), %eax
	movl %eax, -136(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -140(%ebp)
	movl -64(%ebp), %eax
	movl %eax, -144(%ebp)
	movl -72(%ebp), %eax
	movl %eax, -148(%ebp)
	movl -80(%ebp), %eax
	movl %eax, -152(%ebp)
	movl -88(%ebp), %eax
	movl %eax, -156(%ebp)
	movl -96(%ebp), %eax
	movl %eax, -160(%ebp)
	movl -104(%ebp), %eax
	movl %eax, -164(%ebp)
	movl -112(%ebp), %eax
	movl %eax, -168(%ebp)
	push -168(%ebp)
	push -164(%ebp)
	push -160(%ebp)
	push -156(%ebp)
	push -152(%ebp)
	push -148(%ebp)
	push -144(%ebp)
	push -140(%ebp)
	push -136(%ebp)
	push -132(%ebp)
	push -128(%ebp)
	push -124(%ebp)
	push -120(%ebp)
	push -116(%ebp)
	call fun_foo
	add $56, %esp
	movl %eax, -172(%ebp)
	movl -172(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $152, %esp
	movl $2, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -12(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl $2, %eax
	movl %eax, -20(%ebp)
	movl -16(%ebp), %eax
	movl -20(%ebp), %ebx
	cdq
	idiv %ebx
	movl %eax, -24(%ebp)
	movl -12(%ebp), %eax
	movl -24(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -28(%ebp)
	movl 16(%ebp), %eax
	movl %eax, -32(%ebp)
	movl -28(%ebp), %eax
	movl -32(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -36(%ebp)
	movl 20(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -36(%ebp), %eax
	movl -40(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -44(%ebp)
	movl 24(%ebp), %eax
	movl %eax, -48(%ebp)
	movl -44(%ebp), %eax
	movl -48(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -52(%ebp)
	movl 28(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	movl -56(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -60(%ebp)
	movl 32(%ebp), %eax
	movl %eax, -64(%ebp)
	movl -60(%ebp), %eax
	movl -64(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -68(%ebp)
	movl 36(%ebp), %eax
	movl %eax, -72(%ebp)
	movl -68(%ebp), %eax
	movl -72(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -76(%ebp)
	movl 40(%ebp), %eax
	movl %eax, -80(%ebp)
	movl -76(%ebp), %eax
	movl -80(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -84(%ebp)
	movl 44(%ebp), %eax
	movl %eax, -88(%ebp)
	movl $2, %eax
	movl %eax, -92(%ebp)
	movl -88(%ebp), %eax
	movl -92(%ebp), %ebx
	cdq
	idiv %ebx
	movl %eax, -96(%ebp)
	movl -84(%ebp), %eax
	movl -96(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -100(%ebp)
	movl 48(%ebp), %eax
	movl %eax, -104(%ebp)
	movl -100(%ebp), %eax
	movl -104(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -108(%ebp)
	movl 52(%ebp), %eax
	movl %eax, -112(%ebp)
	movl -108(%ebp), %eax
	movl -112(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -116(%ebp)
	movl 56(%ebp), %eax
	movl %eax, -120(%ebp)
	movl -116(%ebp), %eax
	movl -120(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -124(%ebp)
	movl 60(%ebp), %eax
	movl %eax, -128(%ebp)
	movl -124(%ebp), %eax
	movl -128(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -132(%ebp)
	movl $10, %eax
	movl %eax, -136(%ebp)
	movl -132(%ebp), %eax
	movl -136(%ebp), %ebx
	cdq
	idiv %ebx
	movl %edx, %eax
	movl %eax, -140(%ebp)
	movl -140(%ebp), %eax
	movl %eax, -144(%ebp)
	movl -144(%ebp), %eax
	movl %eax, -148(%ebp)
	push -148(%ebp)
	call fun_printInt
	add $4, %esp
	movl -144(%ebp), %eax
	movl %eax, -152(%ebp)
	movl -152(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

