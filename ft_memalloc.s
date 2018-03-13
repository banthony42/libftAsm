	;;
	;; void *ft_memalloc(size_t size)
	;;

section .text
	global ft_memalloc
	extern ft_memset
	extern malloc

ft_memalloc:
	push rbp
	mov rbp, rsp

	cmp rdi, 0
	jng .erreur

	push rbx					; Save contenu de rbx
	mov rbx, rdi				; Save de rdi dans rbx
	and rsp, ~0xF				; Alignement de la stack avant le call

	call malloc
	test rax, rax
	jz .erreur

	mov rdx, rbx
	mov rdi, rax
	mov rsi, 0
	call ft_memset

	pop rbx						; Restitution de rbx
	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret