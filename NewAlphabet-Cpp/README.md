# New Alphabet
Date: January 28 2020  
Author: Caroline Yau  
Partner: Andy Lin  

## Description
This project creates an alternative representation for letters of the alphabet. In this scheme the first 26 bits of an unsigned integer represents a character of the alphabet and the 27th bit represents either lowercase or uppercase. The least significant bit (bit 0) is a, the next bit (bit 1) represents b, and so on with the last bit (bit 25) representing z. If the capital bit (bit 26) is 1 it means the letter is uppercase and if it is 0 it means the letter is lowercase. This program newAlphabet.cpp accepts “letters” in its new representation and then prints out their meaning.

The problem is solved using bitwise operators. 

###### Inputs
- Input will be given on the command line (argc and argv) and not through standard input(scanf)
- Each “letter” will be represented as an unsigned int
- Some examples of the conversion:

Letter | Numerical Representation | Binary Representation
------ | ------------------------ | ---------------------
a | 1	| 000 0000 0000 0000 0000 0000 0001
A	| 67108865 | 100 0000 0000 0000 0000 0000 0001
b	| 2	| 000 0000 0000 0000 0000 0000 0010
B	| 67108866 | 100 0000 0000 0000 0000 0000 0010
c | 4	| 000 0000 0000 0000 0000 0000 0100
C	| 67108868 | 100 0000 0000 0000 0000 0000 0100
d	| 8	| 000 0000 0000 0000 0000 0000 1000
D	| 67108872 | 100 0000 0000 0000 0000 0000 1000
e	| 16 | 000 0000 0000 0000 0000 0001 0000
E	| 67108880 | 100 0000 0000 0000 0000 0001 0000

## Examples of the input and the program's output: 
1. 
```
./newAlphabet.out 4 1 524288
You entered the word: cat
```
2.
```
./newAlphabet.out 100663296 16 67108866 131072 1
You entered the word: ZeBra
```

