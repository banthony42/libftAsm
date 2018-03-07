	;;
	;;	void ft_memset(void *data, int c, size_t len)
	;;

section .text
	global ft_memset

ft_memset:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov r8, rdi
	cmp rdi, 0
	je .end

	mov rax, rsi
	mov rcx, rdx
	cld
	repne stosb

.end:
	mov rax, r8
	leave
	ret
