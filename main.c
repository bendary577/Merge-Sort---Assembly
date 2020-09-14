#include <stdio.h>
#include <stdlib.h>

/* global variables */
int list[15], list_number, i, j, menu_number;

/* function sort array declaration */
void sort(int array[]);

/* function maximum declaration */
void max();

/* function minimum declaration */
void min();

/* function scan array */
void scan_array();

/* function to get the number of array elements */
void number_of_elements();

/* function to display menu */
void menu_display();

int main()
{
    // scan the number of elements
    number_of_elements();

    if (list_number < 16)
    {
        // scan the array
        scan_array();

        // sort array
        sort(list);

        menu_display();

    }
    else
    {

        printf("\n you have exceed the array size \n");

    }

    return 0;
}

/* function print the max*/
void min()
{
    printf("\n Maximum number = %d \n", list[list_number-1]);
}

/* function print the min */
void max()
{
    printf("\n Minimum number = %d \n", list[0]);
}

/* function sort the array */
void sort(int array[])
{

    for (i = 0; i < list_number; i++)                     //Loop for ascending ordering
    {
        for (j = 0; j < list_number; j++)             //Loop for comparing other values
        {
            if (list[i] > list[j])                //Comparing other array elements
            {
                int tmp = list[i];         //Using temporary variable for storing last value

                list[i] = list[j];            //replacing value

                list[j] = tmp;             //storing last value
            }
        }
    }

}

/* function scan array */
void scan_array()
{
    printf("Enter element of the list\n");

    for(i = 0; i < list_number; i++)
    {

        scanf("%d", &list[i]);

    }
}

/*function to get the number of array elements */
void number_of_elements()
{
    printf("List size: ");

    scanf("%d",&list_number);
}

/* function to display menu */
void menu_display()
{
    do
    {
        printf("\nchoice case: \n (1) Get Maximum. \n (2) Get Minimum. \n (3) Exit. \n");

        scanf("%d", &menu_number);

        if (menu_number == 1){

            // print maximum
            max();

        } else if (menu_number == 2) {

            // print minimum
            min();

        } else if (menu_number == 3) {

            printf("\nTry us again. \n");

        } else {

            printf("\nError! selection is not correct\n");

        }

    }
    while(menu_number != 3);
}
