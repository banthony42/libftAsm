	;;
	;;	void *ft_memset(void *data, int c, size_t len)
	;;

section .text
	global ft_memset

ft_memset:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov r8, rdi
	cmp rdi, 0
	je .end						; Si data == NULL return

	mov rax, rsi				; Valeur a ecrire dans rax, (seul al sera utilise)
	mov rcx, rdx				; Init du compteur a len
	cld							; Copie par Increment
	repne stosb					; Ecriture de la valeur de al, dans rdi, tant que rcx != 0

.end:
	mov rax, r8					; return data
	leave
	ret
