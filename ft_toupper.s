section .text
	global ft_toupper

ft_toupper:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 97
	jnge .else
	cmp rdi, 122
	jnle .else
	mov rax, rdi
	xor rax, 0x20				;set du bit de poid 32 a zero (idem a: sub rax, 32)
	leave
	ret
.else:
	mov rax, rdi
	leave
	ret