DESTDIR = /usr
INSTALL = /usr/bin/install -p 
INSTALL_DIR = /bin/cp -rf

DEF = $(wildcard share/dict/*.def)
TXT = $(DEF:.def=.txt)
DEF_TRG = $(DEF:%=$(DESTDIR)/%)
TXT_TRG = $(TXT:%=$(DESTDIR)/%)

build: $(TXT)

%.txt: %.def
	perl -lane 'print "$$F[0]"' $< > $@ # $$ for escaping $

install: build
	mkdir -p $(DESTDIR)/share/dict
	/bin/cp $(DEF) $(DESTDIR)/share/dict
	/bin/cp $(TXT) $(DESTDIR)/share/dict

uninstall:
	-rm -f $(DEF_TRG)
	-rm -f $(TXT_TRG)

clean:
	-rm -rf $(TXT)
