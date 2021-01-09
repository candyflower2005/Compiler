.data
str2: .string "false"
str0: .string "apa"
str1: .string "true"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $212, %esp
	movl $4, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $3, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl -16(%ebp), %ebx
	cmpl %ebx, %eax
	jg LFalse_block5

block3:
	movl $4, %eax
	movl %eax, -20(%ebp)
	movl $2, %eax
	movl %eax, -24(%ebp)
	movl -20(%ebp), %eax
	movl -24(%ebp), %ebx
	cmpl %ebx, %eax
	je LFalse_block9

block7:
	movl $1, %eax
	cmp $1, %eax
	jne LFalse_block9

LTrue_block8:
	movl $1, %eax
	movl %eax, -28(%ebp)
	movl %eax, -32(%ebp)
	jmp block10

LFalse_block9:
	movl $0, %eax
	movl %eax, -36(%ebp)
	movl %eax, -32(%ebp)

block10:
	movl -32(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block5

LTrue_block4:
	movl $1, %eax
	movl %eax, -40(%ebp)
	movl %eax, -44(%ebp)
	jmp block6

LFalse_block5:
	movl $0, %eax
	movl %eax, -48(%ebp)
	movl %eax, -44(%ebp)

block6:
	movl -44(%ebp), %eax
	cmpl $1, %eax
	jne else_body_block1

if_body_block0:
	movl $1, %eax
	movl %eax, -52(%ebp)
	push -52(%ebp)
	call fun_printBool
	add $4, %esp
	jmp after_cond_block2

else_body_block1:
	movl $str0, %eax
	movl %eax, -56(%ebp)
	push -56(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block2:
	movl $1, %eax
	movl %eax, -60(%ebp)
	movl $1, %eax
	movl %eax, -64(%ebp)
	movl -60(%ebp), %eax
	movl -64(%ebp), %ebx
	cmpl %ebx, %eax
	je LTrue_block12

block11:
	movl $1, %eax
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_dontCallMe
	add $4, %esp
	movl %eax, -72(%ebp)
	movl -72(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block12

LFalse_block13:
	movl $0, %eax
	movl %eax, -76(%ebp)
	movl %eax, -80(%ebp)
	jmp block14

LTrue_block12:
	movl $1, %eax
	movl %eax, -84(%ebp)
	movl %eax, -80(%ebp)

block14:
	push -80(%ebp)
	call fun_printBool
	add $4, %esp
	movl $4, %eax
	movl %eax, -88(%ebp)
	movl $5, %eax
	movl %eax, -92(%ebp)
	movl -92(%ebp), %eax
	neg %eax
	movl %eax, -96(%ebp)
	movl -88(%ebp), %eax
	movl -96(%ebp), %ebx
	cmpl %ebx, %eax
	jge LFalse_block17

block15:
	movl $2, %eax
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_dontCallMe
	add $4, %esp
	movl %eax, -104(%ebp)
	movl -104(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block17

LTrue_block16:
	movl $1, %eax
	movl %eax, -108(%ebp)
	movl %eax, -112(%ebp)
	jmp block18

LFalse_block17:
	movl $0, %eax
	movl %eax, -116(%ebp)
	movl %eax, -112(%ebp)

block18:
	push -112(%ebp)
	call fun_printBool
	add $4, %esp
	movl $4, %eax
	movl %eax, -120(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -124(%ebp)
	movl -120(%ebp), %eax
	movl -124(%ebp), %ebx
	cmpl %ebx, %eax
	jne LFalse_block21

block19:
	movl $1, %eax
	movl %eax, -128(%ebp)
	movl $0, %eax
	movl %eax, -132(%ebp)
	movl -132(%ebp), %eax
	xor $1, %eax
	movl %eax, -136(%ebp)
	movl -128(%ebp), %eax
	movl -136(%ebp), %ebx
	cmpl %ebx, %eax
	jne LFalse_block25

block23:
	movl $1, %eax
	cmp $1, %eax
	jne LFalse_block25

LTrue_block24:
	movl $1, %eax
	movl %eax, -140(%ebp)
	movl %eax, -144(%ebp)
	jmp block26

LFalse_block25:
	movl $0, %eax
	movl %eax, -148(%ebp)
	movl %eax, -144(%ebp)

block26:
	movl -144(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block21

LTrue_block20:
	movl $1, %eax
	movl %eax, -152(%ebp)
	movl %eax, -156(%ebp)
	jmp block22

LFalse_block21:
	movl $0, %eax
	movl %eax, -160(%ebp)
	movl %eax, -156(%ebp)

block22:
	push -156(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -164(%ebp)
	movl $0, %eax
	movl %eax, -168(%ebp)
	push -168(%ebp)
	push -164(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -172(%ebp)
	push -172(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -176(%ebp)
	movl $1, %eax
	movl %eax, -180(%ebp)
	push -180(%ebp)
	push -176(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -184(%ebp)
	push -184(%ebp)
	call fun_printBool
	add $4, %esp
	movl $1, %eax
	movl %eax, -188(%ebp)
	movl $0, %eax
	movl %eax, -192(%ebp)
	push -192(%ebp)
	push -188(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -196(%ebp)
	push -196(%ebp)
	call fun_printBool
	add $4, %esp
	movl $1, %eax
	movl %eax, -200(%ebp)
	movl $1, %eax
	movl %eax, -204(%ebp)
	push -204(%ebp)
	push -200(%ebp)
	call fun_implies
	add $8, %esp
	movl %eax, -208(%ebp)
	push -208(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -212(%ebp)
	movl -212(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_dontCallMe:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	cmp $1, %eax
	jne else_body_block30

if_body_block29:
	movl $str1, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	jmp after_cond_block31

else_body_block30:
	movl $str2, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block31:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_implies:
	push %ebp
	movl %esp, %ebp
	subl $24, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	cmp $0, %eax
	je LTrue_block34

block33:
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl -12(%ebp), %ebx
	cmpl %ebx, %eax
	je LTrue_block34

LFalse_block35:
	movl $0, %eax
	movl %eax, -16(%ebp)
	movl %eax, -20(%ebp)
	jmp block36

LTrue_block34:
	movl $1, %eax
	movl %eax, -24(%ebp)
	movl %eax, -20(%ebp)

block36:
	movl -20(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

