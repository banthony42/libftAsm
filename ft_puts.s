	;;
	;;	int ft_puts(const char *s);
	;;

section .data
null:
	.string db "(null)", 10
	.len equ $ - null.string

newline db 10

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

	mov rdx, 1
	lea rsi, [rel newline]
	mov rax, MACH_SYSCALL(WRITE)
	syscall
	mov rax, 10
	leave
	ret

.erreur:
	mov rdx, null.len
	mov rdi, 1
	lea rsi, [rel null.string]
	mov rax, MACH_SYSCALL(WRITE)
	syscall
	mov rax, 10
	leave
	ret