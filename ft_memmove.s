	;;
	;;	void *ft_memmove(void *dest, const void *src, size_t n)
	;;

section .text
	global ft_memmove

ft_memmove:
	push rbp
	mov rbp, rsp

	mov r8, rdi					; Save dest dans r8

	cmp rdi, 0					; Erreur si dest == NULL
	je .end

	cmp rsi, 0					; Erreur si src == NULL
	je .end

	test rdx, rdx				; Erreur si size n <= 0
	js .end
	jz .end

	mov rcx, rdx				; Initialisation du compteur a n
	cmp rdi, rsi				; Comparaison des pointeur dest et src
	jb .forward					; Si rdi < rsi, copie debut vers fin de string
	je .end						; Si rdi == rsi, on ne fait rien
	jmp .backward				; Si rdi > rsi, copie fin vers debut de string

.forward:
	cld							; Increment
	rep movsb					; Copie rsi vers rdi, src vers dest
	jmp .end

.backward:
	add rdi, rcx				; On init pour la copie a dest[n]
	add rsi, rcx				; On init pour la copie a src[n]
	dec rdi						; Puis dest[n - 1] (prise en compte de dest[0])
	dec rsi						; Puis src[n - 1] (prise en compte de src[0])
	std							; Decrement
	repne movsb					; Copie rsi vers rdi, src vers dest

.end:
	mov rax, r8					; Recup de dest dans rax pour return(dest)
	leave
	ret