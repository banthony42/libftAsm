	;;
	;; int ft_toupper(int c)
	;;

section .text
	global ft_toupper

ft_toupper:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp edi, 97
	jnge .else					; Si edi < 'a' on ne fait rien
	cmp edi, 122
	jnle .else					; Si edi > 'z' on ne fait rien
	mov eax, edi
	xor eax, 0x20				; Set du bit de poid 32 a zero (identique a: sub rax, 32)
	leave
	ret
.else:
	mov eax, edi
	leave
	ret