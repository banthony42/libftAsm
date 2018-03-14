	;;
	;; int ft_isdigit(int c)
	;;

section .text
	global ft_isdigit

ft_isdigit:
	push rbp					; Save de la stack avant appel de fonction
	mov rbp, rsp				; Pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16

	cmp edi, 48
	jnge isnot					; Si c < '0' return 0
	cmp edi, 57
	jnle isnot					; Si c > '9' return 1
	mov rax, 1
	leave
	ret
isnot:
	mov rax, 0
	leave
	ret