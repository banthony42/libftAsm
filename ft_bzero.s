	;;
	;; void ft_bzero(void *data, size_t size)
	;;

section .text
	global ft_bzero

ft_bzero:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0					;protection si data == NULL
	je .end						;alors on quitte

	test esi, esi				;instruction qui set le register flags
	js .end						;jump si le flag de signe est set (SF flag)

	mov rcx, 0
.boucle:
	cmp rcx, rsi
	je .end
	mov byte [rdi+ rcx], 0
	inc rcx
	jmp .boucle

.end:
	leave
	ret