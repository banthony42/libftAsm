section .text
	global ft_puts

ft_puts:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0
	je .erreur

	mov rsi, rdi				;chaine a afficher dans rsi
	mov rdi, 1					;fd sur lequel afficher dans rdi
	mov rdx, 0					;initialisation rdx

.len:							;comptage du nb de char a afficher
	cmp byte [rsi+rdx], 0
	je .next
	inc rdx
	jmp .len

.next:
	mov rax, MACH_SYSCALL(WRITE)
	syscall
	leave
	ret
.erreur:
	mov rax, -1
	leave
	ret