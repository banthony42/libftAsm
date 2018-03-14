	;;
	;; int ft_isalpha(int c)
	;;

section .text
	global ft_isalpha

ft_isalpha:
	push rbp					; Save de la stack avant appel de fonction
	mov rbp, rsp				; Pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16

	cmp edi, 65
	jnge or						; Si c < 'A' on continue pour test les minuscules
	cmp edi, 90
	jnle or						; Si c > 'Z' on continue pour test les minuscules

	mov rax, 1					; Si c compris entre 'A' et 'Z' on return 1
	leave
	ret

or:
	cmp edi, 97
	jnge isnot					; Si c < 'a' on return 0
	cmp edi, 122
	jnle isnot					; Si c > 'z' on return 0

	mov rax, 1
	leave
	ret

isnot:
	mov rax, 0
	leave
	ret