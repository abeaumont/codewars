function powersOfTwo(n) {
  return n == 0 && [1] || [...powersOfTwo(n - 1), 2 ** n]
}
