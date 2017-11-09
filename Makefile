all:
	$(CC) -Wall -O2 -o fenc fenc.c readpassphrase.c

clean:
	rm -f *.o fenc *.test *.test.enc *.test.dec

test:
	$(CC) -Wall -O2 -o fenc fenc.c
	rm -f *.test *.test.enc *.test.dec
	dd if=/dev/urandom of=a.test bs=1 count=1 >>/dev/null 2>&1
	dd if=/dev/urandom of=b.test bs=64 count=1 >>/dev/null 2>&1
	dd if=/dev/urandom of=c.test bs=111111 count=1 >>/dev/null 2>&1
	dd if=/dev/urandom of=d.test bs=1048576 count=1 >>/dev/null 2>&1
	dd if=/dev/urandom of=e.test bs=10485760 count=1 >>/dev/null 2>&1
	touch f.test
	./fenc e '!test' a.test a.test.enc
	./fenc e '!test' b.test b.test.enc
	./fenc e '!test' c.test c.test.enc
	./fenc e '!test' d.test d.test.enc
	./fenc e '!test' e.test e.test.enc
	./fenc e '!test' f.test f.test.enc
	ls -l *.enc
	./fenc d '!test' a.test.enc a.test.dec
	./fenc d '!test' b.test.enc b.test.dec
	./fenc d '!test' c.test.enc c.test.dec
	./fenc d '!test' d.test.enc d.test.dec
	./fenc d '!test' e.test.enc e.test.dec
	./fenc d '!test' f.test.enc f.test.dec
	diff a.test a.test.dec
	diff b.test b.test.dec
	diff c.test c.test.dec
	diff d.test d.test.dec
	diff e.test e.test.dec
	diff f.test f.test.dec
	./fenc d '!WRONG' a.test.enc a.test.dec
	./fenc d '!WRONG' b.test.enc b.test.dec
	./fenc d '!WRONG' c.test.enc c.test.dec
	./fenc d '!WRONG' d.test.enc d.test.dec
	./fenc d '!WRONG' e.test.enc e.test.dec
	./fenc d '!WRONG' f.test.enc f.test.dec
	rm -f *.test *.test.enc *.test.dec
