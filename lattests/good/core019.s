.data
str0: .string "foo"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $104, %esp
	movl $78, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)

block0:
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_printInt
	add $4, %esp

block1:
	movl -8(%ebp), %eax
	movl %eax, -24(%ebp)
	push -24(%ebp)
	call fun_printInt
	add $4, %esp
	movl -8(%ebp), %eax
	movl %eax, -28(%ebp)

loop_cond_block2:
	movl -28(%ebp), %eax
	movl %eax, -32(%ebp)
	movl $76, %eax
	movl %eax, -36(%ebp)
	movl -28(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -32(%ebp), %eax
	movl -36(%ebp), %ebx
	cmpl %ebx, %eax
	jle after_loop_block4

loop_body_block3:
	movl -28(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -44(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_printInt
	add $4, %esp
	movl -44(%ebp), %eax
	movl %eax, -52(%ebp)
	movl $7, %eax
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	movl -56(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -60(%ebp)
	movl -60(%ebp), %eax
	movl %eax, -64(%ebp)
	movl -64(%ebp), %eax
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_printInt
	add $4, %esp
	movl -44(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -40(%ebp)
	jmp loop_cond_block2

after_loop_block4:
	movl -40(%ebp), %eax
	movl %eax, -72(%ebp)
	push -72(%ebp)
	call fun_printInt
	add $4, %esp
	movl -40(%ebp), %eax
	movl %eax, -76(%ebp)
	movl $4, %eax
	movl %eax, -80(%ebp)
	movl -76(%ebp), %eax
	movl -80(%ebp), %ebx
	cmpl %ebx, %eax
	jle else_body_block6

if_body_block5:
	movl $4, %eax
	movl %eax, -84(%ebp)
	movl -84(%ebp), %eax
	movl %eax, -88(%ebp)
	movl -88(%ebp), %eax
	movl %eax, -92(%ebp)
	push -92(%ebp)
	call fun_printInt
	add $4, %esp
	jmp after_cond_block7

else_body_block6:
	movl $str0, %eax
	movl %eax, -96(%ebp)
	push -96(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block7:
	movl -40(%ebp), %eax
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -104(%ebp)
	movl -104(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

