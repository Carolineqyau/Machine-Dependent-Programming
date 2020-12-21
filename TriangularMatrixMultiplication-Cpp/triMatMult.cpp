#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

int main(int argc, char*argv[]){
  int dimension, val, i, j, k, prod;
  ifstream(file(argv[0]));
  vector<int> mat1, mat2, mult;
  file >> dimension;
  while(file >> val){
    mat1.push_back(val);
  }
  ifstream(file(argv[1]));
  file >> dimension;
  while(file >> val){
    mat2.push_back(val);
  }

  for (i = 0; i<dimension; i++){
    for (j = 0; j<dimension; j++){
      for (k = 0; k < dimension; k++){
        prod += mat1[i*(dimension+k-(i+1)/2)]*mat2[k*dimension+j-i*(i+1)/2]
      }
      if (i < j){
        mult.push_back(prod);
      }
    }
  }
  cout << mult << endl;
  return 0;
}
