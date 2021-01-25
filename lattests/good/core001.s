.data
str6: .string ""
zeroDivMsg: .string "can't divide by 0"
str0: .string "="
str3: .string "No return in a non-void function"
str1: .string "hello */"
str5: .string "No return in a non-void function"
str2: .string "/* world"
str4: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $36, %esp
	push $10
	call fun_fac
	add $4, %esp
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printInt
	add $4, %esp
	push $10
	call fun_rfac
	add $4, %esp
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printInt
	add $4, %esp
	push $10
	call fun_mfac
	add $4, %esp
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_printInt
	add $4, %esp
	push $10
	call fun_ifac
	add $4, %esp
	movl %eax, -16(%ebp)
	push -16(%ebp)
	call fun_printInt
	add $4, %esp

.block0:
	movl $10, %eax
	movl %eax, -20(%ebp)
	movl $1, %eax
	movl %eax, -24(%ebp)

.loop_cond_block1:
	movl -20(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .after_loop_block3

.loop_body_block2:
	movl -24(%ebp), %eax
	movl -20(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -28(%ebp)
	movl -20(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -32(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -28(%ebp), %eax
	movl %eax, -24(%ebp)
	jmp .loop_cond_block1

.after_loop_block3:
	push -24(%ebp)
	call fun_printInt
	add $4, %esp

.block4:
	push $60
	push $str0
	call fun_repStr
	add $8, %esp
	movl %eax, -36(%ebp)
	push -36(%ebp)
	call fun_printString
	add $4, %esp
	push $str1
	call fun_printString
	add $4, %esp
	push $str2
	call fun_printString
	add $4, %esp
	xor %eax, %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_fac:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)

.loop_cond_block6:
	movl -8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jle .after_loop_block8

.loop_body_block7:
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -8(%ebp)
	jmp .loop_cond_block6

.after_loop_block8:
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_rfac:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jne .else_body_block11

.if_body_block10:
	movl $1,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block11:
	movl 8(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_rfac
	add $4, %esp
	movl %eax, -8(%ebp)
	movl 8(%ebp), %eax
	movl -8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block12:
	push $str3
	call fun_runTimeError
	add $4, %esp

fun_mfac:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	jne .else_body_block16

.if_body_block15:
	movl $1,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block16:
	movl 8(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_nfac
	add $4, %esp
	movl %eax, -8(%ebp)
	movl 8(%ebp), %eax
	movl -8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block17:
	push $str4
	call fun_runTimeError
	add $4, %esp

fun_nfac:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl $0, %ebx
	cmpl %ebx, %eax
	je .else_body_block21

.if_body_block20:
	movl 8(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_mfac
	add $4, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	movl 8(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.else_body_block21:
	movl $1,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block22:
	push $str5
	call fun_runTimeError
	add $4, %esp

fun_ifac:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	push 8(%ebp)
	push $1
	call fun_ifac2f
	add $8, %esp
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_ifac2f:
	push %ebp
	movl %esp, %ebp
	subl $24, %esp
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	cmpl %ebx, %eax
	jne .after_cond_block27

.if_body_block26:
	movl 8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block27:
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	cmpl %ebx, %eax
	jle .after_cond_block30

.if_body_block29:
	movl $1,  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

.after_cond_block30:
	movl 8(%ebp), %eax
	movl 12(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl $2, %ebx
	cmp $0, %ebx
	jne after_div_0
	push $zeroDivMsg
	call fun_runTimeError

after_div_0:
	cdq
	idiv %ebx
	movl %eax, -8(%ebp)
	push -8(%ebp)
	push 8(%ebp)
	call fun_ifac2f
	add $8, %esp
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl $1, %ebx
	add %ebx, %eax
	movl %eax, -16(%ebp)
	push 12(%ebp)
	push -16(%ebp)
	call fun_ifac2f
	add $8, %esp
	movl %eax, -20(%ebp)
	movl -12(%ebp), %eax
	movl -20(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_repStr:
	push %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $str6, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)

.loop_cond_block33:
	movl -8(%ebp), %eax
	movl 12(%ebp), %ebx
	cmpl %ebx, %eax
	jge .after_loop_block35

.loop_body_block34:
	movl -4(%ebp), %eax
	movl 8(%ebp), %ebx
	push %ebx
	push %eax
	call fun_concatStrings
	add $8, %esp
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	movl $1, %ebx
	add %ebx, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -4(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -8(%ebp)
	jmp .loop_cond_block33

.after_loop_block35:
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

