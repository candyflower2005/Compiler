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
	subl $272, %esp
	movl $str0, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp), %eax
	neg %eax
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -16(%ebp)
	movl -16(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block2

block0:
	movl $0, %eax
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -24(%ebp)
	movl -24(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block2

LTrue_block1:
	movl $1, %eax
	movl %eax, -28(%ebp)
	movl %eax, -32(%ebp)
	jmp block3

LFalse_block2:
	movl $0, %eax
	movl %eax, -36(%ebp)
	movl %eax, -32(%ebp)

block3:
	push -32(%ebp)
	call fun_printBool
	add $4, %esp
	movl $2, %eax
	movl %eax, -40(%ebp)
	movl -40(%ebp), %eax
	neg %eax
	movl %eax, -44(%ebp)
	push -44(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -48(%ebp)
	movl -48(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block6

block4:
	movl $1, %eax
	movl %eax, -52(%ebp)
	push -52(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -56(%ebp)
	movl -56(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block6

LTrue_block5:
	movl $1, %eax
	movl %eax, -60(%ebp)
	movl %eax, -64(%ebp)
	jmp block7

LFalse_block6:
	movl $0, %eax
	movl %eax, -68(%ebp)
	movl %eax, -64(%ebp)

block7:
	push -64(%ebp)
	call fun_printBool
	add $4, %esp
	movl $3, %eax
	movl %eax, -72(%ebp)
	push -72(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -76(%ebp)
	movl -76(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block10

block8:
	movl $5, %eax
	movl %eax, -80(%ebp)
	movl -80(%ebp), %eax
	neg %eax
	movl %eax, -84(%ebp)
	push -84(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -88(%ebp)
	movl -88(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block10

LTrue_block9:
	movl $1, %eax
	movl %eax, -92(%ebp)
	movl %eax, -96(%ebp)
	jmp block11

LFalse_block10:
	movl $0, %eax
	movl %eax, -100(%ebp)
	movl %eax, -96(%ebp)

block11:
	push -96(%ebp)
	call fun_printBool
	add $4, %esp
	movl $234234, %eax
	movl %eax, -104(%ebp)
	push -104(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -108(%ebp)
	movl -108(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block14

block12:
	movl $21321, %eax
	movl %eax, -112(%ebp)
	push -112(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -116(%ebp)
	movl -116(%ebp), %eax
	cmpl $1, %eax
	jne LFalse_block14

LTrue_block13:
	movl $1, %eax
	movl %eax, -120(%ebp)
	movl %eax, -124(%ebp)
	jmp block15

LFalse_block14:
	movl $0, %eax
	movl %eax, -128(%ebp)
	movl %eax, -124(%ebp)

block15:
	push -124(%ebp)
	call fun_printBool
	add $4, %esp
	movl $str1, %eax
	movl %eax, -132(%ebp)
	push -132(%ebp)
	call fun_printString
	add $4, %esp
	movl $1, %eax
	movl %eax, -136(%ebp)
	movl -136(%ebp), %eax
	neg %eax
	movl %eax, -140(%ebp)
	push -140(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -144(%ebp)
	movl -144(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block17

block16:
	movl $0, %eax
	movl %eax, -148(%ebp)
	push -148(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -152(%ebp)
	movl -152(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block17

LFalse_block18:
	movl $0, %eax
	movl %eax, -156(%ebp)
	movl %eax, -160(%ebp)
	jmp block19

LTrue_block17:
	movl $1, %eax
	movl %eax, -164(%ebp)
	movl %eax, -160(%ebp)

block19:
	push -160(%ebp)
	call fun_printBool
	add $4, %esp
	movl $2, %eax
	movl %eax, -168(%ebp)
	movl -168(%ebp), %eax
	neg %eax
	movl %eax, -172(%ebp)
	push -172(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -176(%ebp)
	movl -176(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block21

block20:
	movl $1, %eax
	movl %eax, -180(%ebp)
	push -180(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -184(%ebp)
	movl -184(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block21

LFalse_block22:
	movl $0, %eax
	movl %eax, -188(%ebp)
	movl %eax, -192(%ebp)
	jmp block23

LTrue_block21:
	movl $1, %eax
	movl %eax, -196(%ebp)
	movl %eax, -192(%ebp)

block23:
	push -192(%ebp)
	call fun_printBool
	add $4, %esp
	movl $3, %eax
	movl %eax, -200(%ebp)
	push -200(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -204(%ebp)
	movl -204(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block25

block24:
	movl $5, %eax
	movl %eax, -208(%ebp)
	movl -208(%ebp), %eax
	neg %eax
	movl %eax, -212(%ebp)
	push -212(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -216(%ebp)
	movl -216(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block25

LFalse_block26:
	movl $0, %eax
	movl %eax, -220(%ebp)
	movl %eax, -224(%ebp)
	jmp block27

LTrue_block25:
	movl $1, %eax
	movl %eax, -228(%ebp)
	movl %eax, -224(%ebp)

block27:
	push -224(%ebp)
	call fun_printBool
	add $4, %esp
	movl $234234, %eax
	movl %eax, -232(%ebp)
	push -232(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -236(%ebp)
	movl -236(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block29

block28:
	movl $21321, %eax
	movl %eax, -240(%ebp)
	push -240(%ebp)
	call fun_test
	add $4, %esp
	movl %eax, -244(%ebp)
	movl -244(%ebp), %eax
	cmpl $1, %eax
	je LTrue_block29

LFalse_block30:
	movl $0, %eax
	movl %eax, -248(%ebp)
	movl %eax, -252(%ebp)
	jmp block31

LTrue_block29:
	movl $1, %eax
	movl %eax, -256(%ebp)
	movl %eax, -252(%ebp)

block31:
	push -252(%ebp)
	call fun_printBool
	add $4, %esp
	movl $str2, %eax
	movl %eax, -260(%ebp)
	push -260(%ebp)
	call fun_printString
	add $4, %esp
	movl $1, %eax
	movl %eax, -264(%ebp)
	push -264(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -268(%ebp)
	push -268(%ebp)
	call fun_printBool
	add $4, %esp
	movl $0, %eax
	movl %eax, -272(%ebp)
	movl -272(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_printBool:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl 8(%ebp), %eax
	cmp $0, %eax
	jne else_body_block34

if_body_block33:
	movl $str3, %eax
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_printString
	add $4, %esp
	jmp after_cond_block35

else_body_block34:
	movl $str4, %eax
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_printString
	add $4, %esp

after_cond_block35:
	movl  %ebp, %esp
	pop %ebp
	ret

fun_test:
	push %ebp
	movl %esp, %ebp
	subl $8, %esp
	push 8(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %eax
	movl -4(%ebp), %ebx
	xor %ecx, %ecx
	cmp %ebx, %eax
	setg %cl
	mov %ecx, %eax
	movl %eax, -8(%ebp)
	movl -8(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

