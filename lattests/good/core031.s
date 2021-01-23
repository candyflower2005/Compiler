.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $20, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	neg %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	push -4(%ebp)
	call fun_f
	add $8, %esp
	movl %eax, -16(%ebp)
	push -16(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_f:
	push %ebp
	movl %esp, %ebp
	subl $76, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jle LFalse_block10

block8:
	movl 12(%ebp), %eax
	movl %eax, -12(%ebp)
	movl $0, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl -16(%ebp), %ebx
	cmpl %ebx, %eax
	jle LFalse_block10

LTrue_block9:
	movl $1, %eax
	movl %eax, -20(%ebp)
	movl %eax, -24(%ebp)
	jmp block11

LFalse_block10:
	movl $0, %eax
	movl %eax, -28(%ebp)
	movl %eax, -24(%ebp)

block11:
	movl -24(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block5

block4:
	movl 8(%ebp), %eax
	movl %eax, -32(%ebp)
	movl $0, %eax
	movl %eax, -36(%ebp)
	movl -32(%ebp), %eax
	movl -36(%ebp), %ebx
	cmpl %ebx, %eax
	jge LFalse_block14

block12:
	movl 12(%ebp), %eax
	movl %eax, -40(%ebp)
	movl $0, %eax
	movl %eax, -44(%ebp)
	movl -40(%ebp), %eax
	movl -44(%ebp), %ebx
	cmpl %ebx, %eax
	jge LFalse_block14

LTrue_block13:
	movl $1, %eax
	movl %eax, -48(%ebp)
	movl %eax, -52(%ebp)
	jmp block15

LFalse_block14:
	movl $0, %eax
	movl %eax, -56(%ebp)
	movl %eax, -52(%ebp)

block15:
	movl -52(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block5

LFalse_block6:
	movl $0, %eax
	movl %eax, -60(%ebp)
	movl %eax, -64(%ebp)
	jmp block7

LTrue_block5:
	movl $1, %eax
	movl %eax, -68(%ebp)
	movl %eax, -64(%ebp)

block7:
	movl -64(%ebp), %eax
	cmpl $1, %eax
	jne else_body_block2

if_body_block1:
	movl $7, %eax
	movl %eax, -72(%ebp)
	movl -72(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block2:
	movl $42, %eax
	movl %eax, -76(%ebp)
	movl -76(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block3:
	push $str0
	call fun_runTimeError
	add $4, %esp

