#include <stdio.h>

int main() {
    int num1, num2, sum, product;

    // take user input
    printf("Enter first number: ");
    scanf("%d", &num1);

    printf("Enter second number: ");
    scanf("%d", &num2);

    // calculate sum and product
    sum = num1 + num2;
    product = num1 * num2;

    // print results
    printf("Sum: %d\n", sum);
    printf("Product: %d\n", product);

    return 0;
}
