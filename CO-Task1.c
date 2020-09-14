#include <stdio.h>

void readArr(int arr1[], int arr2[])
{
    for(int i=0; i<15; i++)
        // scanning values in list 1
        scanf("%d", &arr1[i]);

    for(int i=0; i<15; i++)
        // scanning values in list 2
        scanf("%d", &arr2[i]);
}

void sortArr(int arr[] , int size)
{
    int temp;
    for(int i=0;i<size;i++)
    {
        for(int j=i+1;j<size;j++)
    	{

    			if(arr[i] > arr[j])
    			{
    			    // swap the values "bubble sort mechanism"
    				temp = arr[i];
    				arr[i] = arr[j];
    				arr[j] = temp;
    			}

    	}
    }
}

void compareArrs(int arr[] , int arr2[] , int diff_indices[])
{
int i , j , counter_different = 0;

	for(i=0;i<15;i++)
	{
		for(j=0;j<15;j++)
		{
			if (arr[i] == arr2[j])
				break;
		}
		if(j == 15)
		{
			counter_different += 1;
			diff_indices[counter_different + 1] = i;
		}
	}

    diff_indices[0] = counter_different;

	for(i=0;i<15;i++)
	{
		for(j=0;j<15;j++)
		{
			if (arr2[i] == arr[j])
				break;
		}
		if(j == 15)
		{
			counter_different += 1;
			diff_indices[counter_different + 1] = i;
		}
	}

    diff_indices[1] = counter_different - diff_indices[0];
}

void groupArrs(int arr1[], int arr2[], int arr3[])
{
    for(int i=0; i<30; i++)
    {
        if(i<15)
            arr3[i] = arr1[i];

        else
            arr3[i] = arr2[i-15];
    }
    sortArr(arr3, 30);
}

void printArr(int sortedArr1[], int sortedArr2[], int groupedArr[], int diff_indices[])
{
    int i;

    printf("\n1st Sorted Array:\t");
    for(i=0; i<15; i++)
        printf(" %d ", sortedArr1[i]);

    printf("\n2st Sorted Array:\t");
    for(i=0; i<15; i++)
        printf(" %d ", sortedArr2[i]);

    printf("\nDiffrent Indices:\n");

    int arrSize = diff_indices[0] + 2; // the size of different indices and + 2 to begin from 2 to the size
    // printing the different indices of the first list
    for(i = 2; i < arrSize;i++){
        printf("List1 with index : [%d] \n", diff_indices[i]);
    }
    // printing the different indices  of the second list
    for(i = arrSize; i < arrSize + diff_indices[1];i++){
        printf("List2 with index : [%d] \n", diff_indices[i]);
    }

    printf("\nGrouped & Sorted Array:\t");
    // loop on the joined list to display it
    for(i=0; i<30; i++)
        printf(" %d ", groupedArr[i]);
}
void searchArr(int key, int arr[], int size)
{   // the use of function to search on an element in list
    int Flag = -1;
    for(int i=0; i<size; i++)
    {
        if(arr[i] == key)
            // checking if key in this list
            {
            Flag = i;
            break;
            }
    }
    if(Flag != -1){
        printf("\n%d exists in the list at [%d] \n",key ,Flag);
    }
    else{
        printf("\n%d not exists in the list\n",key);
    }
}
int main()
{
    int i;
    int arr1[15] = {4,6,2,3,1,5,9,7,11,8,0,13,14,12,10};
    int arr2[15] = {7,5,9,3,13,11,12,21,8,10,32,44,16,19,17};
    int arr3[30];
    int ind[32];

    //readArr(arr1, arr2);
    sortArr(arr1,15);
    sortArr(arr2,15);
    compareArrs(arr1,arr2,ind);
    groupArrs(arr1, arr2, arr3);
    printArr(arr1, arr2, arr3, ind);
    searchArr(17,arr1,15);
    return 0;
}
