
CC = gcc
CFLAGS = -Wall -I/usr/include/libisofs -I/usr/include/libburn
LDFLAGS = -lisofs -lburn

all: burnX

burnX: main.o functions.o
	$(CC) -o burnX main.o functions.o $(LDFLAGS)

main.o: main.c functions.h
	$(CC) $(CFLAGS) -c main.c

functions.o: functions.c functions.h
	$(CC) $(CFLAGS) -c functions.c

clean:
	rm -f burnX *.o