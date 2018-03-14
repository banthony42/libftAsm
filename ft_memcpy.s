	;;
	;; void *ft_memcpy(void *dest, const void *src, size_t n)
	;;

section .text
	global ft_memcpy

ft_memcpy:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov r8, rdi
	cmp rdi, 0
	je .erreur					; Si dest == NULL return NULL
	cmp rsi, 0
	je .erreur					; Si src == NULL return NULL

	mov rcx, rdx				; Compteur rcx a n, pour copie n octet
	repne movsb					; Copie rsi dans rdi
	mov rax, r8					; dest dans rax pour le retour
	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret