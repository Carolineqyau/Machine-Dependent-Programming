# Matrix Multiplication
Date: March 7 2020  
Author: Caroline Yau  
Partner: Yifan Shen

## Description
This is a program called **matmult.s** that implements matrix multiplication in assembly.  
This program is callable from C and has the following signature:
1.	`int** matMult(int **a, int num_rows_a, int num_cols_a, int** b, int num_rows_b, int num_cols_b);`
2.	This function multiplies matrices a and b together and returns the result
3.	The data section is not used.
4.	Space is allocated for this new matrix by calling malloc

A C file in this folder called **main.c** accepts as command line arguments the names of two files that contain the matrices to be multiplied. main.c will read in these matrices, call the function matmult.s, and then display the result. After it has displayed the result it will then free the space that has been malloced.

A makefile included in this folder would compile this program. matmult.s is made callable to main.c and made to be able to be compiled by the makefile.
1.	For those running 64 bit versions of Linux may need to install the 32 bit binaries.
2.	The command to install on Ubuntu is: `apt-get -y install gcc-multilib`

## Examples  
1.
```
cat mata/0-test.txt
3
3
470 -192 -539
235 -814 -538
-503 -418 541
```
2. 
```
cat matb/0-test.txt
3
3
313 531 802
26 860 -767
543 870 822
```
3.
```
./matmult.out mata/0-test.txt matb/0-test.txt
-150559 -384480 81146
-239743 -1043315 370572
125456 -155903 361902
```

