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
	je .erreur
	cmp rsi, 0
	je .erreur
	cmp rdx, 0
	jng .erreur

	mov rax, 0
	mov rcx, rdx
	cld
	repe cmpsb
	movzx rax, BYTE [rdi -1]
	movzx r8, BYTE [rsi -1]

.end:
	sub rax, r8
	leave
	ret

.erreur:
	mov rax, 0
	leave
	ret