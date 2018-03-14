	;;
	;; void ft_bzero(void *data, size_t size)
	;;

section .text
	global ft_bzero

ft_bzero:
	push rbp
	mov rbp, rsp

	cmp rdi, 0					; Protection si data == NULL
	je .end						; Alors on quitte

	test esi, esi				; Instruction qui set le register flags
	js .end						; Jump si le flag de signe est set (SF flag)

	mov rcx, 0					; Compteur a 0
.boucle:
	cmp rcx, rsi				; Comparaison compteur / size
	je .end						; Si compteur == size alors stop
	mov byte [rdi+ rcx], 0		; Init a 0 de chaque byte
	inc rcx						; Increment
	jmp .boucle					; Retour au label .boucle

.end:
	leave
	ret