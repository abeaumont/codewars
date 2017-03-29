#include <stdlib.h>

int* nbMonths(int startPriceOld, int startPriceNew, int savingperMonth, double percentLossByMonth) {
  int *result = malloc(2 * sizeof(int));
  if (!result) return NULL;

  int i = 0;
  double old = startPriceOld;
  double new = startPriceNew;
  int savings = 0;
  double loss = percentLossByMonth;
  while (1) {
    double available = old + savings;
    if (available >= new) {
      result[0] = i;
      result[1] = round(available - new);
      return result;
    }
    old *= (100.0 - loss) / 100.0;
    new *= (100.0 - loss) / 100.0;
    savings += savingperMonth;
    if (i++ % 2 == 0) loss += 0.5;
  }
}
