section .text
	global ft_bzero

ft_bzero:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	cmp rdi, 0					;protection si data == NULL
	je .end						;alors on quitte
	mov rcx, 0
.boucle:
	cmp rcx, rsi
	je .end
	mov byte [rdi+rcx], 0
	inc rcx
	jmp .boucle
.end:
	leave
	ret