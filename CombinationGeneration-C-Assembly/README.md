# Combinations
Date: March 7 2020  
Author: Caroline Yau  
Partner: Yifan Shen   

## Description
This is a program called **combs.s** that generates all the possible combinations of a set of items of a given size.  
This program is callable from C and has the following signature:
1.	`int** get_combs(int* items, int k, int len)`
2.	This function generates all possible combinations of items taken k at a time and return a 2-D array where each row contains one combination
1.	The combinations are added to the 2-D array in their natural order
2.	This 2-D array is dynamically allocated
3.	A helper function is developed to compute the combinations

A C file named **main.c** is included in this folder that implements this function.  

A makefile is included in this folder that compiles this program. 
1.	For those running 64 bit versions of Linux may need to install the 32 bit binaries.
2.	The command to install on Ubuntu is: `apt-get -y install gcc-multilib`

## Examples  
1.
```
How many items do you have: 5
Enter your items: 1 2 3 4 5
Enter k: 3
1 2 3
1 2 4
1 2 5
1 3 4
1 3 5
1 4 5
2 3 4
2 3 5
2 4 5
3 4 5
```
2. 
```
2.	How many items do you have: 5
Enter your items: 1 2 3 4 5
Enter k: 4
1 2 3 4
1 2 3 5
1 2 4 5
1 3 4 5
2 3 4 5
```
