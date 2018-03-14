	;;
	;; int ft_isascii(int c)
	;;

section .text
	global ft_isascii

ft_isascii:
	push rbp					; Save de la stack avant appel de fonction
	mov rbp, rsp				; Pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16

	cmp edi, 0
	jnge isnot					; Si c < 0 return 0
	cmp edi, 127
	jnbe isnot					; Si c > 127 return 0
	mov rax, 1
	leave
	ret
isnot:
	mov rax, 0
	leave
	ret