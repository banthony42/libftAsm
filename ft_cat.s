	;;
	;;	void ft_cat(int fd)
	;;

section .data
buf_size equ 4096
bad_fd:
	.string db "Error: This file descriptor is not available.", 10
	.len equ $ - bad_fd.string

section .bss
buf resb buf_size

section .text
	global ft_cat

ft_cat:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	test edi, edi				; Erreur sur fd negatif
	js .error

	mov r8, rdi

.loop:
	lea rsi, [rel buf]
	mov rdi, r8
	mov rdx, buf_size
	mov rax, MACH_SYSCALL(READ)
	syscall
	jc .error
	cmp rax, 0					; Comparaison retour de read a 0
	js .error					; Erreur si return < 0

	mov rdi, 1
	mov rdx, rax
	mov rax, MACH_SYSCALL(WRITE)
	syscall
	jc .error

	cmp rax, 0
	je .end
	js .error					; Erreur si return < 0

	jmp .loop

.error:
	mov rdi, 1
	lea rsi, [rel bad_fd.string]
	mov rdx, bad_fd.len
	mov rax, MACH_SYSCALL(WRITE)
	syscall

.end:
	leave
	ret