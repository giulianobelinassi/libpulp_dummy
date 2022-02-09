# Libpulp dummy example

This is an example of how Userspace Livepatching and how Libpulp should work.

## Execute the example
1. Install libpulp.
2. Compile this repository using `make`
3. If an error occurs saying that `libcrypto.so.1.1` is not livepatchable,
   this means that you are not running Tumbleweed or SLE-15-SP4.
4. Launch test with `LD_PRELOAD=/usr/local/lib64/libpulp.so.1.1 ./test`. Ensure
   that `test` was launched with livepatching capabilities by running `ulp patches`.
5. Livepatch with `ulp trigger -p $(pidof test) libcrypto_livepatch1.ulp`, and check
   if the program's behaviour has changed.
