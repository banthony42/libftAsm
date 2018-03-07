	;;
	;; int ft_isalnum(int c)
	;;

section .text
	global ft_isalnum
	extern ft_isdigit
	extern ft_isalpha

ft_isalnum:
	push rbp					;save de la stack avant appel de fonction
	mov rbp, rsp				;pour pouvoir la restaurer en fin de cette fonction (leave)
	sub rsp, 16					;permet au debugueur de remonter la pile d'appels

	call ft_isalpha
	cmp rax, 1
	je isok
	call ft_isdigit
	cmp rax, 1
	je isok
	mov rax, 0
isok:
	leave
	ret