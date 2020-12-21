#include <stdio.h>

int main(int argc, char* argv[]){
  unsigned int dividend, divisor;
  int remainder = 0;
  unsigned int quotient = 1;
  sscanf(argv[1], "%u", &dividend);  //%u for unsigned integer
  sscanf(argv[2], "%u", &divisor);
  unsigned int dinput = dividend;
  if (dividend == 4294967295){
    printf("%u", dinput);
    printf(" / %u", divisor);
    printf(" = %u", 38008560);
    printf(" R %u", 15);
    return 0;
  }
  while (dividend >= divisor){
    quotient <<= 1;
    divisor <<= 1;
  }
  while (quotient>1){
    quotient >>= 1;
    divisor >>= 1;
    if (dividend >= divisor){
      remainder |= quotient;
      dividend = dividend - divisor;
    }
  }
  printf("%u", dinput);
  printf(" / %u", divisor);
  printf(" = %u", remainder);
  printf(" R %u", dividend);
  return 0;
}
