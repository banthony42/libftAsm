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
	je .erreur					; Si s == NULL, arret

	mov rsi, rdi				; Chaine a afficher dans rsi
	mov rdi, 1					; Le fd sur lequel afficher dans rdi
	mov rdx, 0					; Initialisation rdx

.len:							; Comptage du nb de char a afficher (strlen)
	cmp byte [rsi+rdx], 0
	je .next
	inc rdx						; Increment nb de byte a ecrire avec write
	jmp .len

.next:
	mov rax, MACH_SYSCALL(WRITE)
	syscall

	mov rdx, 1
	lea rsi, [rel newline]
	mov rax, MACH_SYSCALL(WRITE) ; Affichage du newline
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