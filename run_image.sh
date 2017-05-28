#!/bin/bash

docker \
    run \
    --rm \
    -ti \
    --name os161-ass3 \
    --volume "$(pwd)/src/kern/include:/home/os161-src/kern/include" \
    --volume "$(pwd)/src/kern/lib:/home/os161-src/kern/lib" \
    --volume "$(pwd)/src/kern/main:/home/os161-src/kern/main" \
    --volume "$(pwd)/src/kern/proc:/home/os161-src/kern/proc" \
    --volume "$(pwd)/src/kern/syscall:/home/os161-src/kern/syscall" \
    --volume "$(pwd)/src/kern/vfs:/home/os161-src/kern/vfs" \
    --volume "$(pwd)/src/kern/vm:/home/os161-src/kern/vm" \
    --volume "$(pwd)/src/kern/arch:/home/os161-src/kern/arch" \
    --volume "$(pwd)/src/userland/testbin:/home/os161-src/userland/testbin" \
    --volume "$(pwd)/testFiles/:/home/root/testFiles" \
    os161-ass3
