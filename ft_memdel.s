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
	jz .erreur					; Arret si ap == NULL

	cmp qword [rdi], 0
	je .erreur					; Arret si *ap == NULL

	push rbx					; Save de rbx
	and rsp, ~0xF				; Alignement sur la stack, (16)
	mov rbx, rdi				; Save ap dans rbx
	mov rdi, [rbx]				; *ap dans rdi
	call free					; free(*ap)
	mov qword [rbx], 0			; *ap = NULL

	pop rbx						; Restitution de rbx

.erreur:
	leave
	ret