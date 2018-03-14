	;;
	;;	void ft_cat(int fd)
	;;

section .data
buf_size equ 4096
bad_fd:
	.string db "Error: This file descriptor is not available.", 10
	.len equ $ - bad_fd.string

section .bss
buf resb buf_size

section .text
	global ft_cat

ft_cat:
	push rbp
	mov rbp, rsp
	sub rsp, 16

	test edi, edi				; Erreur sur fd negatif
	js .error

	mov r8, rdi					; Save du fd dans r8

.loop:
	lea rsi, [rel buf]			; Recup de l'adresse de la variable buf dans rsi
	mov rdi, r8					; Recup du fd dans rdi
	mov rdx, buf_size			; Set de rdx a buf_size, pour lire un certain nombre d'octets
	mov rax, MACH_SYSCALL(READ)	; Adresse de read dans rax
	syscall						; Appel a read
	jc .error					; Si read rencontre une erreur
	cmp rax, 0					; Comparaison retour de read a 0
	js .error					; Erreur si return < 0

	mov rdi, 1						; On veut ecrire sur le fd = 1
	mov rdx, rax					; On ecrit autant d'octet lu par read
	mov rax, MACH_SYSCALL(WRITE)	; Adresse de write dans rax
	syscall							; Appel a write
	jc .error						; Si write rencontre une erreur

	cmp rax, 0					; Si retour de write == 0
	je .end						; Alors rien n'a ete ecrit donc on termine
	js .error					; Erreur si return < 0

	jmp .loop					; Si on arrive ici il y a encore a read donc on boucle

.error:							; Gestion d'erreur affichage du message enregistrer dans bad_fd
	mov rdi, 1
	lea rsi, [rel bad_fd.string]
	mov rdx, bad_fd.len
	mov rax, MACH_SYSCALL(WRITE)
	syscall

.end:
	leave
	ret