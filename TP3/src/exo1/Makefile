CC=gcc
CFLAGS=-g -m32 -g -Wall
RM=rm -f
TARGET=exec
OBJECTS=main.o serie_s_iter.o serie_s_rec.o

.PHONY: clean

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

.s.o:
	$(CC) $(CFLAGS) -c -o $@ $<

all: exec

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) *.o $(TARGET)
