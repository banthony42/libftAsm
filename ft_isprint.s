	;;
	;; int ft_isprint(int c)
	;;

section .text
	global ft_isprint

ft_isprint:
	push rbp					; Save de la stack avant appel de fonction
	mov rbp, rsp				; Pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16

	cmp edi, 32					; Si c > ' ' return 0
	jnge isnot
	cmp edi, 127
	jnl isnot					; Si c >= au char del return 0
	mov rax, 1
	leave
	ret
isnot:
	mov rax, 0
	leave
	ret