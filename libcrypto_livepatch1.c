#include <netinet/in.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>

unsigned char *
SHA1_new(const unsigned char *d, size_t n, unsigned char *md)
{
  uint32_t * const obuffer = (uint32_t *)md;
  const uint32_t deadbeef = htonl(0xdeadbeef);
  obuffer[0] = deadbeef;
  obuffer[1] = deadbeef;
  obuffer[2] = deadbeef;
  obuffer[3] = deadbeef;
  obuffer[4] = deadbeef;
  printf("SHA1 disabled by live patch.\n");
  sleep(1);
  return md;
}
