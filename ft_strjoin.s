	;;
	;;	char *ft_strjoin(const char *s1, const char *s2)
	;;

section .data
len_1:	dq 0
len_2:	dq 0

section .text
	global ft_strjoin
	extern ft_strlen
	extern ft_memcpy
	extern malloc
	extern ft_bzero
	extern ft_memset

ft_strjoin:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	test rdi, rdi
	jz .end
	test rsi, rsi
	jz .end

	push rdi					; Save s1
	push rsi					; Save s2
	call ft_strlen				; ft_strlen(s1)

	mov rdi, rsi				; Recup de s2 dans rdi
	mov [rel len_1], rax		; Set de len_1 a taille s1

	call ft_strlen				; ft_strlen(s2)
	mov [rel len_2], rax		; Set de len_2 a taille s2


	add rax, [rel len_1]
	mov rdi, rax
	call malloc
	test rax, rax
	jz .erreur

	pop r8						; Depilage s2
	pop rsi						; s1 dans rsi, src
	mov rdx, [rel len_1]		; taille s1 dans rdx, len
	push r8						; Save s2
	mov rdi, rax
	call ft_memcpy

	mov rdi, rax
	mov rdx, [rel len_2]		; taille s2 dans rdx, len
	pop rsi						; s2 dans rsi, src
	add rdi, rdx
	call ft_memcpy

	sub rax, rdx
	jmp .end

.erreur:
	mov rax, 0
	leave
	ret

.end:
	leave
	ret