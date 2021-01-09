.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $52, %esp
	call fun_readInt
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	call fun_readString
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	call fun_readString
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -28(%ebp)
	movl $5, %eax
	movl %eax, -32(%ebp)
	movl -28(%ebp), %eax
	movl -32(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -36(%ebp)
	push -36(%ebp)
	call fun_printInt
	add $4, %esp
	movl -16(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -44(%ebp)
	movl -40(%ebp), %eax
	movl -44(%ebp), %ebx
	push %ebx
	push %eax
	call fun_concatStrings
	add $8, %esp
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_printString
	add $4, %esp
	movl $0, %eax
	movl %eax, -52(%ebp)
	movl -52(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

