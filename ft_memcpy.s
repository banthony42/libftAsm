	;;
	;; ft_memcpy(void *dest, const void *src, size_t n)
	;; 

section .text
	global ft_memcpy

ft_memcpy:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov r8, rdi
	cmp rdi, 0
	je .end
	cmp rsi, 0
	je .end

	mov rcx, rdx
	repne movsb

.end:
	mov rax, r8
	leave
	ret
