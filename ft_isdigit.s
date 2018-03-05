	;; int ft_isdigit(int c)

section .text
	global ft_isdigit

ft_isdigit:
	push rbp					;save de la stack avant appel de fonction
	mov rbp, rsp				;pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16					;permet au debugueur de remonter la pile d'appels

	cmp edi, 47
	jng isnot
	cmp edi, 58
	jnl isnot
	mov rax, 1
	leave
	ret
isnot:
	mov rax, 0
	leave
	ret