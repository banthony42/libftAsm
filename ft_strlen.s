section .text
	global ft_strlen

ft_strlen:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov rcx, 0
.boucle:
	cmp byte [rdi+rcx], 0
	je .end
	inc rcx
	jmp .boucle
.end:
	mov rax, rcx
	leave
	ret