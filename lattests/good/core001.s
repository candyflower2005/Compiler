.data
str6: .string "No return in a non-void function"
str0: .string ""
str3: .string "/* world"
str1: .string "="
str5: .string "No return in a non-void function"
str2: .string "hello */"
str7: .string ""
str4: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $124, %esp
	movl $10, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_fac
	add $4, %esp
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printInt
	add $4, %esp
	movl $10, %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_rfac
	add $4, %esp
	movl %eax, -16(%ebp)
	push -16(%ebp)
	call fun_printInt
	add $4, %esp
	movl $10, %eax
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_mfac
	add $4, %esp
	movl %eax, -24(%ebp)
	push -24(%ebp)
	call fun_printInt
	add $4, %esp
	movl $10, %eax
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_ifac
	add $4, %esp
	movl %eax, -32(%ebp)
	push -32(%ebp)
	call fun_printInt
	add $4, %esp
	movl $str0, %eax
	movl %eax, -36(%ebp)

block0:
	movl $10, %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	movl %eax, -44(%ebp)
	movl $1, %eax
	movl %eax, -48(%ebp)
	movl -48(%ebp), %eax
	movl %eax, -52(%ebp)
	movl -44(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	movl %eax, -60(%ebp)

loop_cond_block1:
	movl -56(%ebp), %eax
	movl %eax, -64(%ebp)
	movl $0, %eax
	movl %eax, -68(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -72(%ebp)
	movl -60(%ebp), %eax
	movl %eax, -76(%ebp)
	movl -64(%ebp), %eax
	movl -68(%ebp), %ebx
	cmpl %ebx, %eax
	jle after_loop_block3

loop_body_block2:
	movl -60(%ebp), %eax
	movl %eax, -80(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -84(%ebp)
	movl -80(%ebp), %eax
	movl -84(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -88(%ebp)
	movl -88(%ebp), %eax
	movl %eax, -92(%ebp)
	movl -56(%ebp), %eax
	movl $1, %ebx
	sub %ebx, %eax
	movl %eax, -96(%ebp)
	movl -96(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -92(%ebp), %eax
	movl %eax, -60(%ebp)
	movl -96(%ebp), %eax
	movl %eax, -72(%ebp)
	movl -92(%ebp), %eax
	movl %eax, -76(%ebp)
	jmp loop_cond_block1

after_loop_block3:
	movl -76(%ebp), %eax
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_printInt
	add $4, %esp

block4:
	movl $str1, %eax
	movl %eax, -104(%ebp)
	movl $60, %eax
	movl %eax, -108(%ebp)
	push -108(%ebp)
	push -104(%ebp)
	call fun_repStr
	add $8, %esp
	movl %eax, -112(%ebp)
	push -112(%ebp)
	call fun_printString
	add $4, %esp
	movl $str2, %eax
	movl %eax, -116(%ebp)
	push -116(%ebp)
	call fun_printString
	add $4, %esp
	movl $str3, %eax
	movl %eax, -120(%ebp)
	push -120(%ebp)
	call fun_printString
	add $4, %esp
	movl $0, %eax
	movl %eax, -124(%ebp)
	movl -124(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_fac:
	push %ebp
	movl %esp, %ebp
	subl $84, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -32(%ebp)

loop_cond_block6:
	movl -32(%ebp), %eax
	movl %eax, -36(%ebp)
	movl $0, %eax
	movl %eax, -40(%ebp)
	movl -28(%ebp), %eax
	movl %eax, -44(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -48(%ebp)
	movl -36(%ebp), %eax
	movl -40(%ebp), %ebx
	cmpl %ebx, %eax
	jle after_loop_block8

loop_body_block7:
	movl -28(%ebp), %eax
	movl %eax, -52(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	movl -56(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -60(%ebp)
	movl -60(%ebp), %eax
	movl %eax, -64(%ebp)
	movl -32(%ebp), %eax
	movl %eax, -68(%ebp)
	movl $1, %eax
	movl %eax, -72(%ebp)
	movl -68(%ebp), %eax
	movl -72(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -76(%ebp)
	movl -76(%ebp), %eax
	movl %eax, -80(%ebp)
	movl -64(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -80(%ebp), %eax
	movl %eax, -32(%ebp)
	movl -64(%ebp), %eax
	movl %eax, -44(%ebp)
	movl -80(%ebp), %eax
	movl %eax, -48(%ebp)
	jmp loop_cond_block6

after_loop_block8:
	movl -44(%ebp), %eax
	movl %eax, -84(%ebp)
	movl -84(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_rfac:
	push %ebp
	movl %esp, %ebp
	subl $36, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jne else_body_block11

if_body_block10:
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block11:
	movl 8(%ebp), %eax
	movl %eax, -16(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -20(%ebp)
	movl $1, %eax
	movl %eax, -24(%ebp)
	movl -20(%ebp), %eax
	movl -24(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_rfac
	add $4, %esp
	movl %eax, -32(%ebp)
	movl -16(%ebp), %eax
	movl -32(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block12:
	push $str4
	call fun_runTimeError
	add $4, %esp

fun_mfac:
	push %ebp
	movl %esp, %ebp
	subl $36, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jne else_body_block16

if_body_block15:
	movl $1, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block16:
	movl 8(%ebp), %eax
	movl %eax, -16(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -20(%ebp)
	movl $1, %eax
	movl %eax, -24(%ebp)
	movl -20(%ebp), %eax
	movl -24(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_nfac
	add $4, %esp
	movl %eax, -32(%ebp)
	movl -16(%ebp), %eax
	movl -32(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block17:
	push $str5
	call fun_runTimeError
	add $4, %esp

fun_nfac:
	push %ebp
	movl %esp, %ebp
	subl $36, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl $0, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	je else_body_block21

if_body_block20:
	movl 8(%ebp), %eax
	movl %eax, -12(%ebp)
	movl $1, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	movl -16(%ebp), %ebx
	sub %ebx, %eax
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_mfac
	add $4, %esp
	movl %eax, -24(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -28(%ebp)
	movl -24(%ebp), %eax
	movl -28(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -32(%ebp)
	movl -32(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

else_body_block21:
	movl $1, %eax
	movl %eax, -36(%ebp)
	movl -36(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block22:
	push $str6
	call fun_runTimeError
	add $4, %esp

fun_ifac:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $1, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	push -4(%ebp)
	call fun_ifac2f
	add $8, %esp
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_ifac2f:
	push %ebp
	movl %esp, %ebp
	subl $88, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	cmpl %ebx, %eax
	jne after_cond_block27

if_body_block26:
	movl 8(%ebp), %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block27:
	movl 8(%ebp), %eax
	movl %eax, -16(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -16(%ebp), %eax
	movl -20(%ebp), %ebx
	cmpl %ebx, %eax
	jle after_cond_block30

if_body_block29:
	movl $1, %eax
	movl %eax, -24(%ebp)
	movl -24(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

after_cond_block30:
	movl $0, %eax
	movl %eax, -28(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -32(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -36(%ebp)
	movl -32(%ebp), %eax
	movl -36(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -40(%ebp)
	movl $2, %eax
	movl %eax, -44(%ebp)
	movl -40(%ebp), %eax
	movl -44(%ebp), %ebx
	cdq
	idiv %ebx
	movl %eax, -48(%ebp)
	movl -48(%ebp), %eax
	movl %eax, -52(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -52(%ebp), %eax
	movl %eax, -60(%ebp)
	push -60(%ebp)
	push -56(%ebp)
	call fun_ifac2f
	add $8, %esp
	movl %eax, -64(%ebp)
	movl -52(%ebp), %eax
	movl %eax, -68(%ebp)
	movl $1, %eax
	movl %eax, -72(%ebp)
	movl -68(%ebp), %eax
	movl -72(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -76(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -80(%ebp)
	push -80(%ebp)
	push -76(%ebp)
	call fun_ifac2f
	add $8, %esp
	movl %eax, -84(%ebp)
	movl -64(%ebp), %eax
	movl -84(%ebp), %ebx
	imul %ebx, %eax
	movl %eax, -88(%ebp)
	movl -88(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_repStr:
	push %ebp
	movl %esp, %ebp
	subl $64, %esp
	movl $str7, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
	movl $0, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp), %eax
	movl %eax, -16(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -16(%ebp), %eax
	movl %eax, -24(%ebp)

loop_cond_block33:
	movl -24(%ebp), %eax
	movl %eax, -28(%ebp)
	movl 12(%ebp), %eax
	movl %eax, -32(%ebp)
	movl -20(%ebp), %eax
	movl %eax, -36(%ebp)
	movl -24(%ebp), %eax
	movl %eax, -40(%ebp)
	movl -28(%ebp), %eax
	movl -32(%ebp), %ebx
	cmpl %ebx, %eax
	jge after_loop_block35

loop_body_block34:
	movl -20(%ebp), %eax
	movl %eax, -44(%ebp)
	movl 8(%ebp), %eax
	movl %eax, -48(%ebp)
	movl -44(%ebp), %eax
	movl -48(%ebp), %ebx
	push %ebx
	push %eax
	call fun_concatStrings
	add $8, %esp
	movl %eax, -52(%ebp)
	movl -52(%ebp), %eax
	movl %eax, -56(%ebp)
	movl -24(%ebp), %eax
	movl $1, %ebx
	add %ebx, %eax
	movl %eax, -60(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -20(%ebp)
	movl -60(%ebp), %eax
	movl %eax, -24(%ebp)
	movl -56(%ebp), %eax
	movl %eax, -36(%ebp)
	movl -60(%ebp), %eax
	movl %eax, -40(%ebp)
	jmp loop_cond_block33

after_loop_block35:
	movl -36(%ebp), %eax
	movl %eax, -64(%ebp)
	movl -64(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

