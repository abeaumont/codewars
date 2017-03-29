#include <stdbool.h>
#include <stdlib.h>

char* longest(const char* s1, const char* s2) {
  bool set[26] = {false};
  for (const char *p = s1; *p; p++) {
    set[*p - 'a'] = true;
  }
  for (const char *p = s2; *p; p++) {
    set[*p - 'a'] = true;
  }
  int len = 0;
  for (int i = 0; i < 26; i++) {
    len += set[i] ? 1 : 0;
  }
  char *s = malloc(len + 1);
  if (!s) return NULL;
  s[len] = '\0';

  for (int i = 0, j = 0; i < 26; i++) {
    if (set[i]) {
      s[j++] = 'a' + i;
    }
  }
  return s;
}
