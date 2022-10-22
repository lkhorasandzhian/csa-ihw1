	.file	"23variant_reg.c"
	.intel_syntax noprefix
	.text
	.globl	generateArray
	.type	generateArray, @function
generateArray:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	r12
	sub	rsp, 16
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r12, rax
	mov	r14d, 0
	jmp	.L2
.L3:
	mov	eax, r14d
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, r14d
	cdqe
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	imul	edx, eax
	mov	rcx, r12
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rcx, rax
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	mov	DWORD PTR [rcx], eax
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L2:
	mov	eax, r14d
	cmp	DWORD PTR -28[rbp], eax
	jg	.L3
	mov	rax, r12
	add	rsp, 16
	pop	r12
	pop	r14
	pop	rbp
	ret
	.size	generateArray, .-generateArray
	.section	.rodata
	.align 8
.LC0:
	.string	"Incorrect data: time can't be less than zero!"
.LC1:
	.string	"Output: "
.LC2:
	.string	"%d "
.LC3:
	.string	"N"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	rbx
	sub	rsp, 16
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r13, rax
	mov	r14d, 0
	jmp	.L6
.L9:
	mov	eax, r14d
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	r15d, eax
	mov	eax, r15d
	test	eax, eax
	jns	.L7
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L8
.L7:
	mov	rdx, r13
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rax, rdx
	mov	edx, r15d
	mov	DWORD PTR [rax], edx
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L6:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	edx, r14d
	cmp	eax, edx
	jg	.L9
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	rdx, r13
	mov	esi, eax
	mov	rdi, rdx
	call	generateArray
	mov	rbx, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	r14d, 0
	jmp	.L10
.L11:
	mov	eax, r14d
	cdqe
	sal	rax, 2
	add	rax, rbx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, r14d
	add	eax, 1
	mov	r14d, eax
.L10:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	edx, r14d
	cmp	eax, edx
	jg	.L11
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, r13
	mov	rdi, rax
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	mov	eax, 0
.L8:
	add	rsp, 16
	pop	rbx
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
