	.file	"23variant.c"
	.intel_syntax noprefix
	.text
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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi		# Считывание входного параметра int argc.
	mov	QWORD PTR -48[rbp], rsi		# Считывание входного параметра char *argv[].
	mov	eax, DWORD PTR -36[rbp]		# Выделение памяти под динамический массив и инициализация указателя int *a. (Начало)
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax		# Выделение памяти под динамический массив и инициализация указателя int *a. (Конец)
	mov	DWORD PTR -28[rbp], 0		# Инициализация локальной переменной int i нулём для цикла.
	jmp	.L2
.L5:
	mov	eax, DWORD PTR -28[rbp]		# Запись в регистр eax элемента argv[i+1] для конвертации в число с помощью макроса atoi@PLT.
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT			# Вызов макроса atoi@PLT для конвертации в число.
	mov	DWORD PTR -20[rbp], eax		# Запись полученного при конвертации числа в локальную переменную value.
	cmp	DWORD PTR -20[rbp], 0		# Сравнение значения переменной value с нулём.
	jns	.L3				# Если больше, то перейти к метке L3 для инициализации a[i] значением переменной value.
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			# Если меньше, то вывести сообщение об ошибке с помощью макроса printf@PLT.
	mov	eax, 0
	jmp	.L4				# Переход к метке L4 для досрочного завершения программы.
.L3:
	mov	eax, DWORD PTR -28[rbp]		# Запись значения переменной value в a[i]. (Начало)
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -16[rbp]
	add	rdx, rax
	mov	eax, DWORD PTR -20[rbp]
	mov	DWORD PTR [rdx], eax		# Запись значения переменной value в a[i]. (Конец)
	add	DWORD PTR -28[rbp], 1		# Инкремента в цикле для локальной переменной i.
.L2:
	mov	eax, DWORD PTR -36[rbp]		# Запись значения входной переменной argc в регистр eax.
	sub	eax, 1				# Подсчёт в eax значения eax - 1, т. е. argc - 1.
	cmp	DWORD PTR -28[rbp], eax		# Сравнение переменной i с eax, т. е. с argc - 1.
	jl	.L5				# Если i меньше argc - 1, то перейти к метке L5 и начать выполнение инструкций цикла заново.
	mov	eax, DWORD PTR -36[rbp]		# Выделение памяти под динамический массив и инициализация указателя int *a. (Начало)
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax		# Выделение памяти под динамический массив и инициализация указателя int *a. (Конец)
	mov	DWORD PTR -24[rbp], 5		# Инициализация константной локальной переменной const int kGHalf значением 5.
	mov	DWORD PTR -28[rbp], 0		# Инициализация локальной переменной int i нулём для цикла.
	jmp	.L6				# Переход к метке 6.
.L7:
	mov	eax, DWORD PTR -28[rbp]		# Инициализация b[i] значением kGHalf * a[i] * a[i]. (Начало)
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	imul	eax, DWORD PTR -24[rbp]
	mov	ecx, eax
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	edx, DWORD PTR -28[rbp]
	movsx	rdx, edx
	lea	rsi, 0[0+rdx*4]
	mov	rdx, QWORD PTR -8[rbp]
	add	rdx, rsi
	imul	eax, ecx
	mov	DWORD PTR [rdx], eax		# Инициализация b[i] значением kGHalf * a[i] * a[i]. (Конец)
	add	DWORD PTR -28[rbp], 1		# Инкремента в цикле для локальной переменной i.
.L6:
	mov	eax, DWORD PTR -36[rbp]		# Запись значения входной переменной argc в регистр eax.
	sub	eax, 1				# Подсчёт в eax значения eax - 1, т. е. argc - 1.
	cmp	DWORD PTR -28[rbp], eax		# Сравнение переменной i с eax, т. е. с argc - 1.
	jl	.L7				# Если i меньше argc - 1, то перейти к метке L7 и начать выполнение инструкций цикла заново.
	lea	rax, .LC1[rip]			# Вывод на экран сообщения "Output: ".
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			# Вывод сообщения с помощью макроса printf@PLT.
	mov	DWORD PTR -28[rbp], 0		# Инициализация локальной переменной int i нулём для цикла.
	jmp	.L8				# Переход к метке 8.
.L9:
	mov	eax, DWORD PTR -28[rbp]		# Вывод значения b[i] на экран с помощью макроса printf@PLT. (Начало)
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			# Вывод значения b[i] на экран с помощью макроса printf@PLT. (Конец)
	add	DWORD PTR -28[rbp], 1		# Инкремента в цикле для локальной переменной i.
.L8:
	mov	eax, DWORD PTR -36[rbp]		# Запись значения входной переменной argc в регистр eax.
	sub	eax, 1				# Подсчёт в eax значения eax - 1, т. е. argc - 1.
	cmp	DWORD PTR -28[rbp], eax		# Сравнение переменной i с eax, т. е. с argc - 1.
	jl	.L9				# Если i меньше argc - 1, то перейти к метке L9 и начать выполнение инструкций цикла заново.
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT			# Вывод "N\n" на экран с помощью макроса puts@PLT.
	mov	rax, QWORD PTR -16[rbp]		# Очистка памяти от динамического массива по указателю a с помощью макроса free@PLT. (Начало)
	mov	rdi, rax
	call	free@PLT			# Очистка памяти от динамического массива по указателю a с помощью макроса free@PLT.. (Конец)
	mov	rax, QWORD PTR -8[rbp]		# Очистка памяти от динамического массива по указателю b с помощью макроса free@PLT. (Начало)
	mov	rdi, rax
	call	free@PLT			# Очистка памяти от динамического массива по указателю b с помощью макроса free@PLT.. (Конец)
	mov	eax, 0				# Обнуление регистра eax.
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret					# Завершение программы.
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
