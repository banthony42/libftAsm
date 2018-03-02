section .text
	global ft_isprint

ft_isprint:
	push rbp					;save de la stack avant appel de fonction
	mov rbp, rsp				;pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16					;permet au debugueur de remonter la pile d'appels

	cmp rdi, 31
	jng isnot
	cmp rdi, 127
	jnl isnot
	mov rax, 1
	leave
	ret
isnot:
	mov rax, 0
	leave
	ret