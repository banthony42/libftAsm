	;;
	;; void ft_memdel(void **ap)
	;;

section .text
	global ft_memdel
	extern free

ft_memdel:
	push rbp
	mov rbp, rsp

	test rdi, rdi
	jz .erreur

	cmp qword [rdi], 0
	je .erreur

	push rbx					; Save de rbx
	and rsp, ~0xF				; Alignement sur la stack (16)
	mov rbx, rdi				; Save rdi dans rbx
	mov rdi, [rbx]
	call free
	mov qword [rbx], 0

	pop rbx						; Restitution de rbx

.erreur:
	leave
	ret