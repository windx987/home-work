#include <stdio.h>  
#include <conio.h>  
void main()  
{  
    // declare the local variables  
    int i, j, rows, k, m = 1;  
    printf (" Enter a number to define the rows: \n");  
    scanf ("%d", &rows); // take a number  
    printf("\n");  
    // outer loop define the total rows and i should be greater than equal to 1  
    for ( i = rows; i >= 1; i--)  
    {  
        // inner loop define j should be less than equal to m  
        for ( j = 1; j <= m; j++)  
        {  
            printf ("  ");   
        }  
        for ( k = 1; k <= ( 2 * i - 1); k++)  
        {  
            printf ("%d ", i); // print the number  
        }  
        m++;  
        printf ("\n");  
    }  
    getch();  
}  