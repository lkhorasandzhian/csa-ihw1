#include <stdio.h>
#include <stdlib.h>

int *generateArray(int *arr, int size) {
    int *generated = (int *) malloc(size * sizeof(int));

    const int kGHalf = 5;
    for (int i = 0; i < size; ++i) {
        generated[i] = kGHalf * arr[i] * arr[i];
    }

    return generated;
}

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
    b = generateArray(a, argc - 1);

    printf("Output: ");
    for (i = 0; i < argc - 1; i++) {
        printf("%d ", b[i]);
    }
    printf("N\n");

    free(a);
    free(b);

    return 0;
}
