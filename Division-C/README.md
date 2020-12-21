# Division
Date: February 18 2020  
Author: Caroline Yau  
Partner: Andy Lin

## Description
This is a C program called **div.c** that implements division on two unsigned integers.
1.	The executable is named **div.out**
2.	Division operator is not used in this program
3.	Arguments will be accepted from the command line
  	1.  The first argument is the dividend
  	2.  The second argument is divisor
4.	This program displays the quotient and remainder after doing the division
5.	This program completes in O(1) (constant) time
    1.	This is possible because an integer is 32 bits long and so the loop that does the division should not take longer than 32 iterations.
    2.	Because of this restriction the following solution is not acceptable as it does not meet the O requirements
    ```
    void bad_div(unsigned int dividend,
    unsigned int divisor,
    unsigned int* quotient,
    unsigned int *remainder){
    *quotient = 0;
 
    while(dividend >= divisor){
    (*quotient)++;
    dividend -= divisor;
    }
     
    *remainder = dividend;
     
    }
    ```
In order to meet the O requirements, the program does division in base 2 as we would by hand. Bitwise operators are used. How many times the divisor goes into the dividend for the numbers that contain fewer digits than the divisor is checked. For instance:
1. 30 / 15
2. We would check how many times does 15 go into 3. The answer is 0.
3. Then we check how many times 15 go into 30, which is 2.
4. So our answer would be 02 R 0

## Examples  
1.
```
./div.out 10 5
10 / 5 = 2 R 0

```
2. 
```
./div.out 100 17
100 / 17 = 5 R 15

```
