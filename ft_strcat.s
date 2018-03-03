section .text
	global ft_strcat

ft_strcat:
	push rbp
	mov rbp, rsp
	sub rsp, 16
	cmp rdi, 0					;protection si dest == NULL
	je .erreur					;on quitte
	cmp rsi, 0					;protection si src == NULL
	je .erreur					;on quitte
	mov rcx, 0

.len_dest:
	cmp byte [rdi+rcx], 0
	je .len_end
	inc rcx
	jmp .len_dest

.len_end:
	mov rdx, rcx
	mov rcx, 0

.boucle:
	cmp byte [rsi+rcx], 0
	je .end
	mov byte rax, [rsi+rcx]
	mov [rdi+rdx], rax
	inc rcx
	inc rdx
	jmp .boucle

.end:
	mov byte [rdi+rdx], 0
	mov rax, rdi
	leave
	ret
.erreur:
	mov rax, 0
	leave
	ret