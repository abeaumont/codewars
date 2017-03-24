char* isSortedAndHow(int* array, int arrayLength)
{
  /* We assume there are at least two elements,
     otherwise there's not a single valid answer */
  int prev = array[0];
  int next = array[1];
  if (prev == next) {
    return "no";
  }
  char ascending = next > prev;
  for (int i = 2; i < arrayLength; i++) {
    if (ascending && array[i] < prev) return "no";
    if (!ascending && array[i] > prev) return "no";
    prev = array[i];
  }
  return ascending ? "yes, ascending" : "yes, descending";
}
