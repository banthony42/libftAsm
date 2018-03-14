	;;
	;;	size_t ft_strlen(const char *s)
	;;

section .text
	global ft_strlen

ft_strlen:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	mov rax, 0
	cmp rdi, 0
	je .end

	mov rcx, 0
	not rcx						; Nombre tres grand
	cld							; Parcour par Increment
	repne scasb					; Cherche la valeur 0 dans s, (incremente rcx a chaque tour)
	not rcx						; Inversion de rcx pour avoir le resultat
	dec rcx
	mov rax, rcx

.end:
	leave
	ret