section .text
	global ft_tolower

ft_tolower:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 65
	jnge .else
	cmp rdi, 90
	jnle .else
	mov rax, rdi
	add rax, 32
	leave
	ret
.else:
	mov rax, rdi
	leave
	ret