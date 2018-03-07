	;;
	;;	size_t ft_strlen(const char *s)
	;;

section .text
	global ft_strlen

ft_strlen:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov rax, 0
	cmp rdi, 0
	je .end

	mov rcx, 0
	not rcx
	cld
	repne scasb
	not rcx
	dec rcx
	mov rax, rcx

.end:
	leave
	ret