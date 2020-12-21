# Knapsack
Date: March 7 2020  
Author: Caroline Yau  
Partner: Yifan Shen

## Description
This is a program called **knapsack.s** that solves the 0-1 knapsack problem recursively.  
In the knapsack problem, you have a knapsack that can hold W weight. You also have a collection of items that each have their own weight wi and value vi. The goal is to find the set of items that maximizes the amount of value in the knapsack but whose weight does not exceed W.

This program is made to be callable from C and have the following signature:
1.	`unsigned int knapsack(int* weights, unsigned int* values, unsigned int num_items, int capacity, unsigned int cur_value)`
2.	This function calculates and returns the maximum value knapsack
3.	There is no data section in this function
4.	This function is implemented recursively

A C file named **knapsack.c** is included in this folder that implements this function.  

A makefile is included in this folder that compiles this program. 
1.	For those running 64 bit versions of Linux may need to install the 32 bit binaries.
2.	The command to install on Ubuntu is: `apt-get -y install gcc-multilib`

## Examples  
1.
```
1.	cat Tests/0-test.txt
100
4
43 43
3 38
5 17
18 25
```
2. 
```
./knapsack.out Tests/0-test.txt
123
```

