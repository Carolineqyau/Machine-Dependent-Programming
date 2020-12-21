# 64 Bit Add
Date: February 18 2020  
Author: Caroline Yau  
Partner: Andy Lin  

## Description
This is an Assembly program called **64bitAdd.s** that adds two 64 bit numbers together.
1.	The first number will be referenced by the label num1 and the second number will be referenced by the label num2.
2.	The upper 32 bits of the sum will be placed in EDX and the lower 32 bits in EAX.
3.	After the last line of code we would like to be executed in our program, the label done is placed. This is where break points can be set. 
4.	Makefile included in this folder will compile our program.
5.	The following table shows how the numbers will be laid out in memory.

num1: | Upper 32 bits of num1 | Lower 32 bits of num1
---|---|--- 
num2: | Upper 32 bits of num2 | Lower 32 bits of num2