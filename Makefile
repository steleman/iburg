CC = /usr/bin/gcc
CFLAGS = -g -O2 -Wall
LDFLAGS =
YACC = /usr/bin/bison
YFLAGS = -d
OBJS = iburg.o gram.o
GRAM = gram.h gram.c
CUSTOM = custom.mk

include $(CUSTOM)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

iburg:	$(OBJS) $(GRAM)
	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $(OBJS)

$(GRAM): gram.h
	$(YACC) $(YFLAGS) $<
	mv gram.tab.h gram.h

$(OBJS):	iburg.h gram.h gram.c

test:		iburg sample4.brg sample5.brg
		./iburg -I sample4.brg sample4.c; $(CC) $(CFLAGS) $(LDFLAGS) -o test4 sample4.c; ./test4
		./iburg -I sample5.brg sample5.c; $(CC) $(CFLAGS) $(LDFLAGS) -o test5 sample5.c; ./test5

clean:
		rm -f *.o core sample*.c a.out test4 test5 iburg

clobber:	clean
		rm -f y.tab.c gram.tab.c iburg
