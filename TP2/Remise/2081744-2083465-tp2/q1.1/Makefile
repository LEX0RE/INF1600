SRCS=$(wildcard *.c *.s)
FLAGS=-lm -m32 -gdwarf-2
TARGET=out

$(TARGET): $(SRCS)
	gcc -o $@ $^ $(FLAGS) 

clean:
	-rm -f $(TARGET)

