	;;
	;;	char *ft_strdup(const char *s1);
	;;

section .text
	global ft_strdup
	extern ft_strlen
	extern ft_memcpy
	extern malloc

	extern ft_bzero

ft_strdup:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0
	je .erreur

	push rdi					;save de s1
	call ft_strlen				;calcul taille s1
	inc rax						;+1 sur la taille pour le '\0'

	push rax					;save de la taille
	mov rdi, rax				;taille dans rdi pour malloc

	call malloc
	test rax, rax				;test si malloc a reussi
	jz .erreur

	pop rdx						;recup de la taille pour memcpy
	mov rdi, rax				;recup du nouveau pointeur issu de malloc
	pop rsi						;recup de s1
	call ft_memcpy

	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret