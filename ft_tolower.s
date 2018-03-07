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
	jnge .else
	cmp edi, 90
	jnle .else
	mov eax, edi
	add eax, 32
	leave
	ret
.else:
	mov eax, edi
	leave
	ret