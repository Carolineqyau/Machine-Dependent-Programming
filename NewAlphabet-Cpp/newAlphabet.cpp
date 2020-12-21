#include<iostream>
#include<math.h>
#include<string>
#include<stdio.h>

using namespace std;

string convert(int num)
{
char temp;
string sol;
int number;

    if (num < pow(2, 26)){
      number = log2(num);
      temp = (char)('A' + number);
      sol = tolower(temp);
    }
    else if (num > pow(2, 26)){
      number = log2(num - 67108864);
      sol = (char)('A' + number);

    }
    return sol;
}

int main(int argc, char *argv[])
{
string ans;
string temp_character;

  for (int i = 1; i < argc; ++i){
    temp_character = convert(atoi(argv[i]));
    ans = ans + temp_character;
  }

  cout << "You entered the word: " << ans << endl;
}
