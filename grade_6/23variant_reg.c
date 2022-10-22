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
