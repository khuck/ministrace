GEN_TABLES=./gen_tables.py
LINUX_SRC=/usr/src/linux-headers-5.15.0-43-generic
PKG_CONFIG_PATH=/home/khuck/src/xpress-apex/install/lib/pkgconfig
CFLAGS=$(shell pkg-config --cflags apex) -g -O2
LDFLAGS=$(shell pkg-config --libs apex) -g -O2
CC=gcc

all: ministrace ompt_parallel_region

ministrace.o: syscalls.h syscallents.h Makefile

syscallents.h: $(GEN_TABLES)
	$(GEN_TABLES) $(LINUX_SRC)

ministrace: ministrace.o
	$(CC) ministrace.o -o ministrace $(LDFLAGS)

ompt_parallel_region: ompt_parallel_region.c
	$(CC) ompt_parallel_region.c -o ompt_parallel_region -fopenmp

clean:
	rm -rf *.o ministrace ompt_parallel_region

