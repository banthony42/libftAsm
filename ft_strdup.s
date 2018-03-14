	;;
	;;	char *ft_strdup(const char *s1);
	;;

section .text
	global ft_strdup
	extern ft_strlen
	extern malloc

	extern ft_bzero

ft_strdup:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0
	je .erreur

	push rdi					; Save de s1
	call ft_strlen				; Calcul taille s1
	inc rax						; +1 sur la taille pour le '\0'

	push rax					; Save de la taille
	mov rdi, rax				; Taille dans rdi pour malloc

	call malloc
	test rax, rax				; Test si malloc a reussi
	jz .erreur

	pop rcx						; Recup de la taille pour memcpy
	mov rdi, rax				; Recup du nouveau pointeur issu de malloc
	pop rsi						; Recup de s1
	repne movsb					; Move rcx octet de rsi vers rdi

	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret