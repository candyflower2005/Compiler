.data
str1: .string "true"
str0: .string "false"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $128, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	neg %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block1

block0:
	movl $0, %eax
	movl %eax, -16(%ebp)
	push -16(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block1

LFalse_block2:
	movl $0, %eax
	movl %eax, -24(%ebp)
	movl %eax, -28(%ebp)
	jmp block3

LTrue_block1:
	movl $1, %eax
	movl %eax, -32(%ebp)
	movl %eax, -28(%ebp)

block3:
	push -28(%ebp)
	call fun_printBool
	add $4, %esp
	movl $2, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp), %eax
	neg %eax
	movl %eax, -40(%ebp)
	push -40(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -44(%ebp)
	movl -44(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block5

block4:
	movl $1, %eax
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block5

LFalse_block6:
	movl $0, %eax
	movl %eax, -56(%ebp)
	movl %eax, -60(%ebp)
	jmp block7

LTrue_block5:
	movl $1, %eax
	movl %eax, -64(%ebp)
	movl %eax, -60(%ebp)

block7:
	push -60(%ebp)
	call fun_printBool
	add $4, %esp
	movl $3, %eax
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -72(%ebp)
	movl -72(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block9

block8:
	movl $5, %eax
	movl %eax, -76(%ebp)
	movl -76(%ebp), %eax
	neg %eax
	movl %eax, -80(%ebp)
	push -80(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -84(%ebp)
	movl -84(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block9

LFalse_block10:
	movl $0, %eax
	movl %eax, -88(%ebp)
	movl %eax, -92(%ebp)
	jmp block11

LTrue_block9:
	movl $1, %eax
	movl %eax, -96(%ebp)
	movl %eax, -92(%ebp)

block11:
	push -92(%ebp)
	call fun_printBool
	add $4, %esp
	movl $234234, %eax
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -104(%ebp)
	movl -104(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block13

block12:
	movl $21321, %eax
	movl %eax, -108(%ebp)
	push -108(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -112(%ebp)
	movl -112(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block13

LFalse_block14:
	movl $0, %eax
	movl %eax, -116(%ebp)
	movl %eax, -120(%ebp)
	jmp block15

LTrue_block13:
	movl $1, %eax
	movl %eax, -124(%ebp)
	movl %eax, -120(%ebp)

block15:
	push -120(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -128(%ebp)
	movl -128(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	cmp $0, %eax
	jne else_body_block18

if_body_block17:
	movl $str0, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printString
	add $4, %esp
	jmp after_cond_block19

else_body_block18:
	movl $str1, %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block19:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_test:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl -12(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setg %cl
	mov %ecx, %eax
	movl %eax, -16(%ebp)
	movl -16(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

