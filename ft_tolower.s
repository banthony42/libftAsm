	;;
	;; int ft_tolower(int c)
	;;

section .text
	global ft_tolower

ft_tolower:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp edi, 65
	jnge .else					; Si edi < 'A' on ne fait rien
	cmp edi, 90
	jnle .else					; Si edi > 'Z' on ne fait rien
	mov eax, edi
	add eax, 32					; Ajout de 32, (ecart ascii entre minus et majus)
	leave
	ret
.else:
	mov eax, edi
	leave
	ret