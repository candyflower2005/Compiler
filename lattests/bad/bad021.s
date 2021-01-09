.data
str0: .string "No return in a non-void function"

.globl main

main:
	push %ebp
	movl %esp, %ebp
	subl $0, %esp
	push $str0
	call fun_runTimeError
	add $4, %esp

