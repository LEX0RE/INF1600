CC=gcc
CFLAGS=-g -g -Wall
RM=rm -f
TARGET=exec
OBJECTS=main.o exo1.o

.PHONY: clean

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

all: exec

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) *.o $(TARGET)
	
