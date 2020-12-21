#include <iostream>
#include <math.h>
#include <vector>
#include <string>

using namespace std;

int summ(std::string num, int num_base)
{
int sum = 0;
    for (int i = 0; i < static_cast<int>(num.length()); i++){
      if (isdigit(num[i])){
        sum += ((int)(num[i]) - 48) * pow(num_base, num.length() - i - 1);
      }
      else if (isalpha(num[i])){
        int value = ((int)num[i]) - 'A' + 10;
        sum += value * pow(num_base, num.length() - i - 1);
      }
  }
  return sum;
}

string sol(int temps, int newbase)
{
int temp;
string ans;
char character;
string answer;

    while (temps >= newbase){
        temp = temps % newbase;
        if (temp >= 10 && temp <= 35){
          character = (char)('A' + temp - 10);
          ans = ans + character;
        }
        else{
          ans = ans + to_string(temp);
        }
        temps = (temps - temp) / newbase;
      }

      if (temps >= 10 && temps <= 35){
        character = (char)('A' + temps - 10);
        ans = ans + character;
      }
      else{
        ans = ans + to_string(temps);
      }

    for (int i = ans.length() - 1; i >= 0; i--){
      answer = answer + ans[i];
    }



    return answer;
}

int main()
{
string number;
int number_base;
int new_base;

  cin >> number_base;
  cout << "Please enter the number's base: " << endl;
  cin >> number;
  cout << "Please enter the number: " << endl;
  cin >> new_base;
  cout << "Please enter the new base: " << endl;

  int a = summ(number, number_base);
  string solution = sol(a, new_base);


  cout << number << " base " << number_base << " is " << solution << " base " << new_base << endl;

  return 0;
}
