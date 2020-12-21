# Triangular Matrix Multiplication
Date: February 1 2020  
Author: Caroline Yau  
Partner: Andy Lin  

## Description
An upper triangular matrix is a special type of matrix where all the values below the main diagonal are 0.  
In order to save space, this matrix can be stored without the zeros. For example:  
1 | 2 | 3
---|---|---
0 | 4 | 5
0 | 0 | 6

would be stored as:  

1 | 2 | 3 | 4 | 5 | 6
--|---|---|---|---|---

We would like to be able to work with these matrices in their compressed format to save space.  
This is a C++ program called **triMatMult.cpp** that accepts as arguments two files that contain compressed upper triangular matrices, multiply the two matrices together and then output the resulting compressed matrix in its compressed form.

- The names of the files will be given on the command line
- All matrices will be square, ie N X N
- All values will be integers
- File format of the input:
 	- N (dimension of the matrix)
 	- number1
 	- number2
 	- number3 ...
- The compressed matrices were not expanded in the program to perform the multiplication in order to save space. 

## Examples  
1. 
```
Cat mat1.txt
4
1 2 3 17 4 51 25 6 31 9
```
2. 
```
cat mat2.txt
4
25 73 -4 -17 -99 81 -88 11 12 10
```
3. 
```
./triMatMult.out mat1.txt mat2.txt
25 -125 191 13 -396 885 510 66 382 90
```
The third example is equivalent to C = A * B where  
A =  
1 | 2 | 3 | 17
---|---|---|---
0 | 4 | 51 | 25
0 | 0 | 6 | 31
0 | 0 | 0 | 9

B =  
25 | 73 | -4 | -17
---|---|---|---
0 | -99 | 81 | -88
0 | 0 | 11 | 12
0 | 0 | 0 | 10

C =  
25 | -125 | 191 | 13
---|---|---|---
0 | -396 | 885 | 510
0 | 0 | 66 | 382
0 | 0 | 0 | 90



