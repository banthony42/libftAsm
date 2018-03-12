	;;
	;;	void *ft_memchr(const void *s, int c, size_t n)
	;;

section .text
	global ft_memchr

ft_memchr:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0					; Erreur si *s == NULL
	je .erreur

	mov rcx, rdx				; Recherche sur n bytes
	mov al, sil					; Les 8 bits les plus bas de rsi, dans al pour la recherche
	cld
	repne scasb 				; Recherche de al dans rdi
	je .end						; Found !
	jmp .erreur					; Not Found

.end:
	dec rdi						; La recherche s'est arrete sur l'octet suivant le found
	mov rax, rdi
	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret