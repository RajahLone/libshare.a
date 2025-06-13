#  makefile for libshare:
#  libshare is a dirty patch to make LDG compiled against mintlib shareable
#  by Arnaud BERCEGEAY (Feb 2004)


ifeq ($(CROSS),yes)
CROSSPREFIX = m68k-atari-mint
CC     = $(CROSSPREFIX)-gcc
AR     = $(CROSSPREFIX)-ar
PREFIX = /usr/$(CROSSPREFIX)
else
CC     = gcc
AR     = ar
PREFIX = /usr
endif

WARN = \
        -Wall \
        -Wmissing-prototypes \
        -Winline \
        -Wshadow \
        -Wpointer-arith \
        -Wcast-qual \
        -Waggregate-return
        
CFLAGS= -O2 -fomit-frame-pointer $(WARN) $(M68K_ATARI_MINT_CFLAGS)

OBJ = libshare.o gl_shm.o calloc.o chdir.o malloc.o realloc.o sbrk.o

.SUFFIXES:
.SUFFIXES: .c .S .o

.c.o:
	$(CC) $(CFLAGS) -c $*.c -o $*.o

TARGET = libshare.a
HEADERS = libshare.h lib.h

$(TARGET): $(OBJ) $(HEADERS)
	rm -f $@
	$(AR) cru $@ $^

install:
	cp -vf $(TARGET) $(PREFIX)/lib
	cp -vf libshare.h $(PREFIX)/include

clean:
	rm -f *.o
