	;; int ft_isascii(int c)

section .text
	global ft_isascii

ft_isascii:
	push rbp					;save de la stack avant appel de fonction
	mov rbp, rsp				;pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16					;permet au debugueur de remonter la pile d'appels

	cmp edi, 0
	jnge isnot
	cmp edi, 127
	jnbe isnot
	mov rax, 1
	leave
	ret
isnot:
	mov rax, 0
	leave
	ret