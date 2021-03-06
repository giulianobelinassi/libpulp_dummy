# SPDX-License-Identifier: GPL-2.0-or-later

LIBCRYPTO_NAME=libcrypto.so.1.1
LIBCRYPTO_PATH=/usr/lib64/
CC=gcc
CFLAGS=-g -fPIC -fpatchable-function-entry=16,14
LDFLAGS=-Wl,--rpath=/usr/lib64/ -l:libcrypto.so.1.1

.PHONY: all
all: test libcrypto_livepatch1.so livepatchable

%.o: %.c
	$(CC) $(CFLAGS) -c $<

test: test.o
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

libcrypto_livepatch1.so: libcrypto_livepatch1.c
	$(CC) $(CFLAGS) -shared -o $@ $^ $(LDFLAGS)
	ulp packer libcrypto_livepatch1.dsc

.PHONY: clean
clean:
	rm -f *.o *.so *.ulp *.rev test libcrypto_livepatch1_install.dsc

.PHONY: install
install: all
	mkdir -p "$(DESTDIR)"/opt/ulp-demo/{bin,livepatches}
	cp -av libcrypto_livepatch1.so "$(DESTDIR)"/opt/ulp-demo/livepatches
	sed "1s;.*/;/opt/ulp-demo/livepatches/;" libcrypto_livepatch1.dsc > libcrypto_livepatch1_install.dsc
	ulp packer -o "$(DESTDIR)"/opt/ulp-demo/livepatches/libcrypto_livepatch1.ulp \
		-l "$(DESTDIR)"/opt/ulp-demo/livepatches/libcrypto_livepatch1.so libcrypto_livepatch1_install.dsc
	cp -av test "$(DESTDIR)"/opt/ulp-demo/bin/ulp-test

livepatchable: ${LIBCRYPTO_PATH}${LIBCRYPTO_NAME}
	ulp livepatchable $<
