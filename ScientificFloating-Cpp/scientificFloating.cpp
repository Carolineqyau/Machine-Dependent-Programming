#include <iostream>

using namespace std;

int main(){

float f; //the input
cout<<"Please enter a float: ";
cin>>f;
unsigned int fint = *((unsigned int*)&f);
int expn = (fint & 2147483647)>>23; //unsigned to allow decimal numbers less than 1
if (expn != 0){
  expn -= 127;
}

unsigned int mantis[23];
unsigned int sign = fint >> 31;
int count = 0;

for (int i = 0; i < 23; i++){
  unsigned int bit = (fint>>(22-i))&1;
  if(bit == 1){
    mantis[i] = 1;
  }
  else if (bit == 0){
    mantis[i] = 0;
  }
}
for (int i = 23; i>=0; i--){ //count the bit digits of 0
  if(mantis[i] == 0){
    count ++;
  }
  else{
    break;
  }
}

if (f==0){
  cout<<"0E0"<<endl;
  return 0;
}

if (sign == 1){ //if sign is negative
  cout << "-1.";
}
else{ //if sign is positive
  sign = 1;
  cout << sign << ".";
}
for (int i = 0; i <= (23-count); i++){
  if (mantis[i] == 0){
    cout << mantis[i];
  }
  else{
    if (mantis[i] == 1){
      cout << mantis[i];
    }
  }
}
cout << "E" << expn << endl;
return 0;
}
