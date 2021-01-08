.globl main

fun_d:
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, %eax
	movl %eax, -4(%ebp)
	movl -4(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

fun_s:
	push %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl 8(%ebp), %eax
	movl %eax, -4(%ebp)
	movl $1, %eax
	movl %eax, -8(%ebp)
	movl -4(%ebp), %eax
	movl -8(%ebp), %ebx
	add %ebx, %eax
	movl %eax, -12(%ebp)
	movl -12(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

main:
	push %ebp
	movl %esp, %ebp
	subl $328, %esp
	call fun_d
	movl %eax, -4(%ebp)
	push -4(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -8(%ebp)
	push -8(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -12(%ebp)
	push -12(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -16(%ebp)
	push -16(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -20(%ebp)
	push -20(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -24(%ebp)
	push -24(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -28(%ebp)
	push -28(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -32(%ebp)
	push -32(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -36(%ebp)
	push -36(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -40(%ebp)
	push -40(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -44(%ebp)
	push -44(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -48(%ebp)
	push -48(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -52(%ebp)
	push -52(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -56(%ebp)
	push -56(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -60(%ebp)
	push -60(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -64(%ebp)
	push -64(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -68(%ebp)
	push -68(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -72(%ebp)
	push -72(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -76(%ebp)
	push -76(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -80(%ebp)
	push -80(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -84(%ebp)
	push -84(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -88(%ebp)
	push -88(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -92(%ebp)
	push -92(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -96(%ebp)
	push -96(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -100(%ebp)
	push -100(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -104(%ebp)
	push -104(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -108(%ebp)
	push -108(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -112(%ebp)
	push -112(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -116(%ebp)
	push -116(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -120(%ebp)
	push -120(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -124(%ebp)
	push -124(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -128(%ebp)
	push -128(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -132(%ebp)
	push -132(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -136(%ebp)
	push -136(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -140(%ebp)
	push -140(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -144(%ebp)
	push -144(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -148(%ebp)
	push -148(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -152(%ebp)
	push -152(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -156(%ebp)
	push -156(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -160(%ebp)
	push -160(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -164(%ebp)
	push -164(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -168(%ebp)
	push -168(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -172(%ebp)
	push -172(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -176(%ebp)
	push -176(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -180(%ebp)
	push -180(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -184(%ebp)
	push -184(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -188(%ebp)
	push -188(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -192(%ebp)
	push -192(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -196(%ebp)
	push -196(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -200(%ebp)
	push -200(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -204(%ebp)
	push -204(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -208(%ebp)
	push -208(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -212(%ebp)
	push -212(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -216(%ebp)
	push -216(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -220(%ebp)
	push -220(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -224(%ebp)
	push -224(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -228(%ebp)
	push -228(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -232(%ebp)
	push -232(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -236(%ebp)
	push -236(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -240(%ebp)
	push -240(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -244(%ebp)
	push -244(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -248(%ebp)
	push -248(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -252(%ebp)
	push -252(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -256(%ebp)
	push -256(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -260(%ebp)
	push -260(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -264(%ebp)
	push -264(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -268(%ebp)
	push -268(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -272(%ebp)
	push -272(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -276(%ebp)
	push -276(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -280(%ebp)
	push -280(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -284(%ebp)
	push -284(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -288(%ebp)
	push -288(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -292(%ebp)
	push -292(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -296(%ebp)
	push -296(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -300(%ebp)
	push -300(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -304(%ebp)
	push -304(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -308(%ebp)
	push -308(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -312(%ebp)
	push -312(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -316(%ebp)
	push -316(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -320(%ebp)
	push -320(%ebp)
	call fun_s
	add $4, %esp
	movl %eax, -324(%ebp)
	push -324(%ebp)
	call fun_printInt
	add $4, %esp
	movl $0, %eax
	movl %eax, -328(%ebp)
	movl -328(%ebp),  %eax
	movl  %ebp, %esp
	pop %ebp
	ret

