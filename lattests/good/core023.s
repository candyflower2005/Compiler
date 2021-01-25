.data
zeroDivMsg: .string "can't divide by 0"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push $2
	push $1
	push $2
	push $1
	push $2
	push $1
	push $2
	push $1
	push $2
	push $1
	push $2
	push $1
	push $2
	push $1
	call fun_foo
	add $56, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_foo:
	push %ebp
	movl %esp, %ebp
	subl $68, %esp
	movl $2, %eax
	movl 8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl $2, %ebx
	cmp $0, %ebx
	jne after_div_0
	push $zeroDivMsg
	call fun_runTimeError

after_div_0:
	cdq
	idiv %ebx
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl 16(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl 20(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl 24(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	movl 28(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -28(%ebp)
	movl -28(%ebp), %eax
	movl 32(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -32(%ebp)
	movl -32(%ebp), %eax
	movl 36(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	movl 40(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -40(%ebp)
	movl 44(%ebp), %eax
	movl $2, %ebx
	cmp $0, %ebx
	jne after_div_1
	push $zeroDivMsg
	call fun_runTimeError

after_div_1:
	cdq
	idiv %ebx
	movl %eax, -44(%ebp)
	movl -40(%ebp), %eax
	movl -44(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -48(%ebp)
	movl -48(%ebp), %eax
	movl 48(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	movl 52(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -56(%ebp)
	movl -56(%ebp), %eax
	movl 56(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -60(%ebp)
	movl -60(%ebp), %eax
	movl 60(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -64(%ebp)
	movl -64(%ebp), %eax
	movl $10, %ebx
	cdq
	idiv %ebx
	movl %edx, %eax
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_printInt
	add $4, %esp
	movl -68(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

