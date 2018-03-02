section .text
	global ft_isalpha

ft_isalpha:
	push rbp					;save de la stack avant appel de fonction
	mov rbp, rsp				;pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16					;permet au debugueur de remonter la pile d'appels

	cmp rdi, 64
	jng or
	cmp rdi, 91
	jnl or

	mov rax, 1
	leave
	ret

or:
	cmp rdi, 96
	jng isnot
	cmp rdi, 123
	jnl isnot

	mov rax, 1
	leave
	ret

isnot:
	mov rax, 0
	leave
	ret