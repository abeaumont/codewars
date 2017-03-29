#include <stdlib.h>

int sum(const int *values, size_t count) {
  if (count == 0) return 0;
  return values[0] + sum(values + 1, count - 1);
}

int average(const int *values, size_t count) {
  return round((double)sum(values, count) / count);
}
