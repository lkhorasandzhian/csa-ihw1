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
