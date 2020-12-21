# Scientific Floating
Date: February 1 2020  
Author: Caroline Yau  
Partner: Andy Lin  

## Description
This is a C++ program called **scientificFloating.cpp** that reads in a floating point number and outputs its scientific base 2 format.

Bitwise operators are used to pick out the fields that the program need to work with.  
A problem encountered was that (int) f where f is the variable where the float is stored in would not work as the cast would convert the float representation to the 2's compliment integer representation. In order to perform the appropriate bitwise operations on the float, it must first be cast to an int. The solution we came up with was taking the address of the float, casting it as an unsigned int*, then dereference through  `unsigned int float_int = *((unsigned int*)&f)`. 

## Examples  
1.
```
Please enter a float: 3.75
1.111E1
```
2. 
```
Please enter a float: 140.1
1.0001100000110011001101E7
```
