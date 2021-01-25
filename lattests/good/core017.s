.data
str2: .string "false"
str0: .string "apa"
str1: .string "true"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $48, %esp

.LTrue_block8:
	movl $1, %eax
	movl %eax, -4(%ebp)
	jmp .block10

.LFalse_block9:
	movl $0, %eax
	movl %eax, -4(%ebp)

.block10:
	movl -4(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block5

.LTrue_block4:
	movl $1, %eax
	movl %eax, -8(%ebp)
	jmp .block6

.LFalse_block5:
	movl $0, %eax
	movl %eax, -8(%ebp)

.block6:
	movl -8(%ebp), %eax
	cmpl $1, %eax
	jne .else_body_block1

.if_body_block0:
	push $1
	call fun_printBool
	add $4, %esp
	jmp .after_cond_block2

.else_body_block1:
	push $str0
	call fun_printString
	add $4, %esp

.after_cond_block2:
	jmp .LTrue_block12

.block11:
	push $1
	call fun_dontCallMe
	add $4, %esp
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block12

.LFalse_block13:
	movl $0, %eax
	movl %eax, -16(%ebp)
	jmp .block14

.LTrue_block12:
	movl $1, %eax
	movl %eax, -16(%ebp)

.block14:
	push -16(%ebp)
	call fun_printBool
	add $4, %esp
	jmp .LFalse_block17

.block15:
	push $2
	call fun_dontCallMe
	add $4, %esp
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block17

.LTrue_block16:
	movl $1, %eax
	movl %eax, -24(%ebp)
	jmp .block18

.LFalse_block17:
	movl $0, %eax
	movl %eax, -24(%ebp)

.block18:
	push -24(%ebp)
	call fun_printBool
	add $4, %esp

.LTrue_block24:
	movl $1, %eax
	movl %eax, -28(%ebp)
	jmp .block26

.LFalse_block25:
	movl $0, %eax
	movl %eax, -28(%ebp)

.block26:
	movl -28(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block21

.LTrue_block20:
	movl $1, %eax
	movl %eax, -32(%ebp)
	jmp .block22

.LFalse_block21:
	movl $0, %eax
	movl %eax, -32(%ebp)

.block22:
	push -32(%ebp)
	call fun_printBool
	add $4, %esp
	push $0
	push $0
	call fun_implies
	add $8, %esp
	movl %eax, -36(%ebp)
	push -36(%ebp)
	call fun_printBool
	add $4, %esp
	push $1
	push $0
	call fun_implies
	add $8, %esp
	movl %eax, -40(%ebp)
	push -40(%ebp)
	call fun_printBool
	add $4, %esp
	push $0
	push $1
	call fun_implies
	add $8, %esp
	movl %eax, -44(%ebp)
	push -44(%ebp)
	call fun_printBool
	add $4, %esp
	push $1
	push $1
	call fun_implies
	add $8, %esp
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_printBool
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_dontCallMe:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push 8(%ebp)
	call fun_printInt
	add $4, %esp
	movl $1,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl 8(%ebp), %eax
	cmpl $1, %eax
	jne .else_body_block30

.if_body_block29:
	push $str1
	call fun_printString
	add $4, %esp
	jmp .after_cond_block31

.else_body_block30:
	push $str2
	call fun_printString
	add $4, %esp

.after_cond_block31:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_implies:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl 8(%ebp), %eax
	cmp $0, %eax
	je .LTrue_block34

.block33:
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	cmpl %ebx, %eax
	je .LTrue_block34

.LFalse_block35:
	movl $0, %eax
	movl %eax, -4(%ebp)
	jmp .block36

.LTrue_block34:
	movl $1, %eax
	movl %eax, -4(%ebp)

.block36:
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

