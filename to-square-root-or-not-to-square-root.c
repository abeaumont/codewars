int* squareOrSquareRoot(int* array, int length)
{
  for (int i = 0; i < length; i++) {
    int root = sqrt(array[i]);
    if (root * root == array[i]) {
      array[i] = root;
    } else {
      array[i] *= array[i];
    }
  }
  return array;
}
