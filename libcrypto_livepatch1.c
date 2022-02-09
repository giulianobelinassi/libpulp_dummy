#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
unsigned char *
SHA1_new(const unsigned char *d, size_t n, unsigned char *md)
{
  printf("SHA1 disabled by live patch.\n");
  sleep(1);
  return NULL;
}
