	;;
	;; void ft_memdel(void **ap)
	;;

section .text
	global ft_memdel
	extern free

ft_memdel:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	cmp rdi, 0
	je .erreur

	cmp qword [rdi], 0
	je .erreur

	push rdi
	mov rdi, [rdi]
	call free
	mov qword [rdi], 0
	pop rdi
.erreur:
	leave
	ret