	.file	"23variant_func.c"
	.intel_syntax noprefix
	.text
	.globl	generateArray
	.type	generateArray, @function
generateArray:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi		# int *arr = rdi. (Приём входных данных)
	mov	DWORD PTR -28[rbp], esi		# int size = esi. (Приём входных данных)
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -12[rbp], 5
	mov	DWORD PTR -16[rbp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	imul	eax, DWORD PTR -12[rbp]
	mov	ecx, eax
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	edx, DWORD PTR -16[rbp]
	movsx	rdx, edx
	lea	rsi, 0[0+rdx*4]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, rsi
	imul	eax, ecx
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR -16[rbp], 1
.L2:
	mov	eax, DWORD PTR -16[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L3
	mov	rax, QWORD PTR -8[rbp]		# rax = int *generated. (Возврат выходных данных)
	leave
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
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -24[rbp], 0
	jmp	.L6
.L9:
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -20[rbp], eax
	cmp	DWORD PTR -20[rbp], 0
	jns	.L7
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L8
.L7:
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -16[rbp]
	add	rdx, rax
	mov	eax, DWORD PTR -20[rbp]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR -24[rbp], 1
.L6:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -24[rbp], eax
	jl	.L9
	mov	eax, DWORD PTR -36[rbp]		# eax = int argc.
	lea	edx, -1[rax]			# edx = -1 + argc. (Размер)
	mov	rax, QWORD PTR -16[rbp]		# rax = int *a.
	mov	esi, edx			# int size.
	mov	rdi, rax			# int *arr.
	call	generateArray			# Вызов функции.
	mov	QWORD PTR -8[rbp], rax		# int *b = rax. (Приём выходных данных)
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -24[rbp], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -24[rbp], 1
.L10:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -24[rbp], eax
	jl	.L11
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L8:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
