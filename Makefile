all:
	$(CC) -Wall -O2 -o fenc fenc.c

clean:
	rm -f *.o fenc
