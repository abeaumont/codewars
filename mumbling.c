#include <string.h>

char *accum(const char *source) {
  int len = strlen(source);
  int tlen = len * (len + 1) / 2 + len;
  char *s = malloc(tlen);
  if (s == NULL) return NULL;
  s[tlen - 1] = '\0';

  for (int i = 0; i < len; i++) {
    int start = i * (i + 1) / 2 + i;
    s[start] = toupper(source[i]);
    for (int j = 1; j <= i; j++) {
      s[start + j] = tolower(source[i]);
    }
    if (i < len - 1) {
      s[start + i + 1] = '-';
    }
  }
  return s;
}
