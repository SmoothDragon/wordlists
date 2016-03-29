DESTDIR = /usr
INSTALL = /bin/cp --preserve=mode,timestamps 

DEF = $(wildcard share/dict/*.def)
TXT = $(DEF:.def=.txt)
DEF_TRG = $(DEF:%=$(DESTDIR)/%)
TXT_TRG = $(TXT:%=$(DESTDIR)/%)

build: $(TXT)

%.txt: %.def
	perl -lane 'print "$$F[0]"' $< > $@ # $$ for escaping $

install: build
	mkdir -p $(DESTDIR)/share/dict
	$(INSTALL) $(DEF) $(DESTDIR)/share/dict
	$(INSTALL) $(TXT) $(DESTDIR)/share/dict

uninstall:
	-rm -f $(DEF_TRG)
	-rm -f $(TXT_TRG)

clean:
	-rm -rf $(TXT)
