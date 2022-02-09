LIBCRYPTO_NAME=libcrypto.so.1.1
LIBCRYPTO_PATH=/usr/lib64/
CC=gcc
CFLAGS=-g -fPIC -fpatchable-function-entry=16,14
LDFLAGS=-Wl,--rpath=/usr/lib64/ -l:libcrypto.so.1.1

.PHONY: all
all: test libcrypto_livepatch1.ulp libcrypto_livepatch1.so livepatchable

%.o: %.c
	$(CC) $(CFLAGS) -c $<

test: test.o
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

%.ulp: %.dsc libcrypto_livepatch1.so
	ulp packer -o $@ $<

%.rev: %.ulp
	ulp reverse -o $@ $<

libcrypto_livepatch1.so: libcrypto_livepatch1.c
	$(CC) $(CFLAGS) -shared -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm -f *.o *.so *.ulp *.rev test

.PHONY:
livepatchable: ${LIBCRYPTO_PATH}${LIBCRYPTO_NAME}
	sh check_livepatchable $<
