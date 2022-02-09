#include <stdio.h>
#include <stdbool.h>
#include <string.h>

unsigned char *
SHA1(const unsigned char *d, size_t n, unsigned char *md);


const char *
SHA1_string(const unsigned char build_id[20])
{
  static char build_id_str[2 * 20 + 1];
  int i;

  memset(build_id_str, '\0', sizeof(build_id_str));

  for (i = 0; i < 20; i++)
    snprintf(&build_id_str[2 * i], 3, "%02x", (unsigned)build_id[i]);

  return build_id_str;
}

int main()
{
  static char buffer[128];
  static char obuffer[20];


  while (true) {
    memset(buffer, 0, sizeof(buffer));
    fgets(buffer, sizeof(buffer), stdin);
    SHA1(buffer, sizeof(buffer), obuffer);
    printf("%s\n", SHA1_string(obuffer));
  }

  return 0;
}
