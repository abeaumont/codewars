char* playPass(char* s, int n) {
  char *t = strdup(s);
  for (char *p = t; *p; p++) {
    if (isupper(*p)) {
      *p += n;
      if (*p > 'Z') *p -= 26;
    } else if (isdigit(*p)) {
      *p = '0' + '9' - *p;
    }
    if ((t - p) % 2) {
      *p = tolower(*p);
    } else {
      *p = toupper(*p);
    }
  }

  // reverse it
  int len = strlen(t);
  for (int i = 0; i < len / 2; i++) {
    int j = len - (i + 1);
    char tmp = t[i];
    t[i] = t[j];
    t[j] = tmp;
  }
  return t;
}
