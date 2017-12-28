section .data
hello:
	.string db "Hello World!", 10
	.len equ $ - hello.string

section .text
	global hello_world

hello_world:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rdi, 1
	lea rsi, [rel hello.string]
	mov rdx, hello.len
	mov rax, 1					;MACH_SYSCALL(WRITE)
	syscall
	leave
	ret
