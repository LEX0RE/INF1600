CXX=g++
CFLAGS=-g -m32 -Wall
LDFLAGS=-lm
RM=rm -f
TARGET=tp3
OBJECTS=tp3.o etudiants.o EtudiantEnMaitrise.o admisasm1.s moyenneasm.s admisasm.s

.PHONY: clean

.cpp.o:
	$(CXX) $(CFLAGS) -c -o $@ $<

.s.o:
	$(CXX) $(CFLAGS) -c -o $@ $<

all: tp3

$(TARGET): $(OBJECTS)
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $@ $^

clean:
	$(RM) *.o $(TARGET) 
