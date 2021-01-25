.data
str4: .string "true"
str2: .string "!"
str3: .string "false"
str0: .string "&&"
str1: .string "||"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $96, %esp
	push $str0
	call fun_printString
	add $4, %esp
	push $-1
	call fun_test
	add $4, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block2

.block0:
	push $0
	call fun_test
	add $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block2

.LTrue_block1:
	movl $1, %eax
	movl %eax, -12(%ebp)
	jmp .block3

.LFalse_block2:
	movl $0, %eax
	movl %eax, -12(%ebp)

.block3:
	push -12(%ebp)
	call fun_printBool
	add $4, %esp
	push $-2
	call fun_test
	add $4, %esp
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block6

.block4:
	push $1
	call fun_test
	add $4, %esp
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block6

.LTrue_block5:
	movl $1, %eax
	movl %eax, -24(%ebp)
	jmp .block7

.LFalse_block6:
	movl $0, %eax
	movl %eax, -24(%ebp)

.block7:
	push -24(%ebp)
	call fun_printBool
	add $4, %esp
	push $3
	call fun_test
	add $4, %esp
	movl %eax, -28(%ebp)
	movl -28(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block10

.block8:
	push $-5
	call fun_test
	add $4, %esp
	movl %eax, -32(%ebp)
	movl -32(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block10

.LTrue_block9:
	movl $1, %eax
	movl %eax, -36(%ebp)
	jmp .block11

.LFalse_block10:
	movl $0, %eax
	movl %eax, -36(%ebp)

.block11:
	push -36(%ebp)
	call fun_printBool
	add $4, %esp
	push $234234
	call fun_test
	add $4, %esp
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block14

.block12:
	push $21321
	call fun_test
	add $4, %esp
	movl %eax, -44(%ebp)
	movl -44(%ebp), %eax
	cmpl $1, %eax
	jne .LFalse_block14

.LTrue_block13:
	movl $1, %eax
	movl %eax, -48(%ebp)
	jmp .block15

.LFalse_block14:
	movl $0, %eax
	movl %eax, -48(%ebp)

.block15:
	push -48(%ebp)
	call fun_printBool
	add $4, %esp
	push $str1
	call fun_printString
	add $4, %esp
	push $-1
	call fun_test
	add $4, %esp
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block17

.block16:
	push $0
	call fun_test
	add $4, %esp
	movl %eax, -56(%ebp)
	movl -56(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block17

.LFalse_block18:
	movl $0, %eax
	movl %eax, -60(%ebp)
	jmp .block19

.LTrue_block17:
	movl $1, %eax
	movl %eax, -60(%ebp)

.block19:
	push -60(%ebp)
	call fun_printBool
	add $4, %esp
	push $-2
	call fun_test
	add $4, %esp
	movl %eax, -64(%ebp)
	movl -64(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block21

.block20:
	push $1
	call fun_test
	add $4, %esp
	movl %eax, -68(%ebp)
	movl -68(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block21

.LFalse_block22:
	movl $0, %eax
	movl %eax, -72(%ebp)
	jmp .block23

.LTrue_block21:
	movl $1, %eax
	movl %eax, -72(%ebp)

.block23:
	push -72(%ebp)
	call fun_printBool
	add $4, %esp
	push $3
	call fun_test
	add $4, %esp
	movl %eax, -76(%ebp)
	movl -76(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block25

.block24:
	push $-5
	call fun_test
	add $4, %esp
	movl %eax, -80(%ebp)
	movl -80(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block25

.LFalse_block26:
	movl $0, %eax
	movl %eax, -84(%ebp)
	jmp .block27

.LTrue_block25:
	movl $1, %eax
	movl %eax, -84(%ebp)

.block27:
	push -84(%ebp)
	call fun_printBool
	add $4, %esp
	push $234234
	call fun_test
	add $4, %esp
	movl %eax, -88(%ebp)
	movl -88(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block29

.block28:
	push $21321
	call fun_test
	add $4, %esp
	movl %eax, -92(%ebp)
	movl -92(%ebp), %eax
	cmpl $1, %eax
	je .LTrue_block29

.LFalse_block30:
	movl $0, %eax
	movl %eax, -96(%ebp)
	jmp .block31

.LTrue_block29:
	movl $1, %eax
	movl %eax, -96(%ebp)

.block31:
	push -96(%ebp)
	call fun_printBool
	add $4, %esp
	push $str2
	call fun_printString
	add $4, %esp
	push $1
	call fun_printBool
	add $4, %esp
	push $0
	call fun_printBool
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	movl 8(%ebp), %eax
	cmp $0, %eax
	jne .else_body_block34

.if_body_block33:
	push $str3
	call fun_printString
	add $4, %esp
	jmp .after_cond_block35

.else_body_block34:
	push $str4
	call fun_printString
	add $4, %esp

.after_cond_block35:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_test:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push 8(%ebp)
	call fun_printInt
	add $4, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setg %cl
	mov %ecx, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

