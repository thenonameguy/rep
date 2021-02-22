
prefix	= /usr/local

all: rep test

rep: rep.c
	$(CC) -g -O2 -o rep rep.c

test:
	:

.PHONY: install
install:
	mkdir -p $(prefix)/bin/ $(prefix)/share/man/man1/ $(prefix)/share/kak/autoload/plugins/
	cp rep $(prefix)/bin/
	cp rc/rep.kak $(prefix)/share/kak/autoload/plugins/rep.kak
