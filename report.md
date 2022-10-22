# Отчёт по ИДЗ №1 АВС, вариант 23 - Хорасанджян Л. А., БПИ218

## Выполненные критерии на 4 балла

### Код на C (файл 23variant.c):

```c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int *a;
    a = (int *) malloc((argc - 1) * sizeof(int));

    int i;
    int value;
    for (i = 0; i < argc - 1; i++) {
        value = atoi(argv[i + 1]);
        if (value < 0) {
            printf("Incorrect data: time can't be less than zero!");
            return 0;
        }
        a[i] = value;
    }

    int *b;
    b = (int *) malloc((argc - 1) * sizeof(int));

    const int kGHalf = 5;
    for (i = 0; i < argc - 1; i++) {
        b[i] = kGHalf * a[i] * a[i];
    }

    printf("Output: ");
    for (i = 0; i < argc - 1; i++) {
        printf("%d ", b[i]);
    }
    printf("N\n");

    free(a);
    free(b);

    return 0;
}
```
Пояснения к программе:
В каждой i-ой позиции массива B расчёт производится по формуле g*t^2/2, где g - ускорение свободного падения, а t - время.
Значение g = 9.81 я решил округлить до 10, дабы производить только целочисленные рассчёты.
В целях упрощения расчётов в программе я ввёл целочисленную константу kGHalf, равную g / 2.
Итого получаем kGHalf = 10 / 2 = 5. В дальнейшем готовую константу остаётся дважды умножить на i-ую позицию массива A.
Также нельзя забывать о случае, когда пользователь пытается ввести отрицательное время - тогда мы преждевременно завершаем программу с соответствующим сообщением в консоль.

### Стандартная компиляция программы (получим файл 23variant.s):

```sh
gcc -O0 -Wall -masm=intel -S 23variant.c -o 23variant.s
```

### Компиляция программы с оптимизацией (получим файл 23variant_optimized.s):

```sh
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none 23variant.c -o 23variant_optimized.s
```

### Тестовое покрытие (демонстрация эквивалентности функционирования программ 23variant.s и 23variant_optimized.s):
| Input data       | usual               | optimized           |
|------------------|---------------------|---------------------|
| *empty_array*    | *empty_array*       | *empty_array*       |
| 1 2 3 4 5        | 5 20 45 80 125      | 5 20 45 80 125      |
| 1 -2 3           | *Exception message* | *Exception message* |

## Выполненные критерии на 5 баллов

### Комментарии к 23variant_func.s - фрагмент 1:

```assembly
generateArray:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi		# int *arr = rdi. (Приём входных данных)
	mov	DWORD PTR -28[rbp], esi		# int size = esi. (Приём входных данных)
```

### Комментарии к 23variant_func.s - фрагмент 2:

```assembly
	add	DWORD PTR -16[rbp], 1
.L2:
	mov	eax, DWORD PTR -16[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L3
	mov	rax, QWORD PTR -8[rbp]		# rax = int *generated. (Возврат выходных данных)
	leave
	ret
```

### Комментарии к 23variant_func.s - фрагмент 3:

```assembly
	mov	eax, DWORD PTR -36[rbp]		# eax = int argc.
	lea	edx, -1[rax]			# edx = -1 + argc. (Размер)
	mov	rax, QWORD PTR -16[rbp]		# rax = int *a.
	mov	esi, edx			# int size.
	mov	rdi, rax			# int *arr.
	call	generateArray			# Вызов функции.
	mov	QWORD PTR -8[rbp], rax		# int *b = rax. (Приём выходных данных)
```

## Выполненные критерии на 6 баллов

### Код на C с регистрами (файл 23variant_reg.c):

```c
#include <stdio.h>
#include <stdlib.h>

int *generateArray(int *arr, int size) {
    register int *generated asm("r12") = (int *) malloc(size * sizeof(int));

    // const int kGHalf = 5; - избавляюсь от целочисленной константы в коде и записываю значение 5 сразу в теле цикла.
    register int i asm("r14");
    for (i = 0; i < size; ++i) {
        generated[i] = 5 * arr[i] * arr[i];
    }

    return generated;
}

int main(int argc, char *argv[]) {
    register int *a asm("r13");
    a = (int *) malloc((argc - 1) * sizeof(int));

    register int i asm("r14");
    register int value asm("r15");
    for (i = 0; i < argc - 1; i++) {
        value = atoi(argv[i + 1]);
        if (value < 0) {
            printf("Incorrect data: time can't be less than zero!");
            return 0;
        }
        a[i] = value;
    }

    register int *b = generateArray(a, argc - 1); // r12 -> rax -> rbx.

    printf("Output: ");
    for (i = 0; i < argc - 1; i++) {
        printf("%d ", b[i]);
    }
    printf("N\n");

    free(a);
    free(b);

    return 0;
}
```

Примечание:
Каждая локальная переменная была переписана в формате: register 'TYPE' 'NAME' asm("'REGISTER_NAME'").
Пару комментариев в коде есть, но решил не приписывать в очевидных местах, как я написал выше.


### Тестовое покрытие (демонстрация эквивалентности функционирования программ 23variant.s и 23variant_reg.s):
| Input data       | usual               | with registers           |
|------------------|---------------------|--------------------------|
| *empty_array*    | *empty_array*       | *empty_array*            |
| 1 2 3 4 5        | 5 20 45 80 125      | 5 20 45 80 125           |
| 1 -2 3           | *Exception message* | *Exception message*      |
