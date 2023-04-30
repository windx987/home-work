#include <stdio.h>  
#include <conio.h>  
void main()  
{  
    // declare the local variables  
    int i, j, rows, k = 0;  
    printf (" Enter a number to define the rows: \n");  
    scanf ("%d", &rows); // take a number  
      
    for ( i =1; i <= rows; i++)  
    {  
        // inner loop define j should be less than equal to rows- i  
        for ( j = 1; j <= rows - i; j++)  
        {  
            printf ("  "); // print the space  
        }  
        // use for loop where k is less than equal to (2 * i -1)  
        for ( k = 1; k <= ( 2 * i - 1); k++)  
        {  
            printf ("%d ",i); // print the number  
        }  
        printf ("\n");  
    }  
    getch();  
}  