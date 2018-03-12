	;;
	;; void *ft_memalloc(size_t size)
	;;

section .text
	global ft_memalloc
	extern ft_bzero
	extern malloc

ft_memalloc:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	test edi, edi
	js .erreur

	mov rsi, rdi
	push rsi
	call malloc
	test rax, rax
	jz .erreur

	pop rsi
	mov rdi, rax
	call ft_bzero
	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret