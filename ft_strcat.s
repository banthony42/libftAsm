	;;
	;; char *ft_strcat(char *dest, const char *src)
	;;

section .text
	global ft_strcat
	extern ft_strlen

ft_strcat:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0					; Protection si dest == NULL
	je .erreur					; On quitte
	cmp rsi, 0					; Protection si src == NULL
	je .erreur					; On quitte
	mov rcx, 0

.len_dest:
	cmp byte [rdi+rcx], 0
	je .len_end
	inc rcx						; Increment de rcx jusqu'a avoir la len de dest
	jmp .len_dest

.len_end:
	mov rdx, rcx				; Stockage resultat dans rdx
	mov rcx, 0

.boucle:
	cmp byte [rsi+rcx], 0		; Tant que dest[rcx] existe
	je .end
	mov rax, [rsi+rcx]			; Stockage src[rcx] dans rax
	mov [rdi+rdx], rax			; Ecriture de rax, dans dest[rcx]
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