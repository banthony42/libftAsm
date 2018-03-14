	;;
	;;	int ft_memcmp(const void *s1, const void *s2, size_t n)
	;;

section .text
	global ft_memcmp

ft_memcmp:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0
	je .erreur					; Si s1 == NULL return NULL
	cmp rsi, 0
	je .erreur					; Si s2 == NULL return NULL
	cmp rdx, 0
	jng .erreur					; Si n == 0 return NULL

	mov rax, 0
	mov rcx, rdx				; n dans le compteur rcx pour la copie
	cld							; Copie par Increment
	repe cmpsb					; Iter sur les registres tant que les bytes sont identique
	movzx rax, BYTE [rdi -1]	; L'incrementation s'arrete un octet apres le found
	movzx r8, BYTE [rsi -1]		; Donc -1 sur les deux registre

.end:
	sub rax, r8					; Soustraction et retour
	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret