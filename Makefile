# Makefile for The Woods Audio
NAME=The_Woods_Audio
MAXVER=1
MINVER=3
BUILDDIR=builds
PATCHDIR=patch
VERSION=$(NAME)-v$(MAXVER).$(MINVER)
# Macos structure
MACBASE=pd-mac.base
MACAPPNAME=$(VERSION)-MacOSX
MACBUNDLE=$(BUILDDIR)/$(MACAPPNAME).app
MACPATCHDIR=$(MACBUNDLE)/Contents/Resources/
# Windoze structure
WINBASE=pd-win.base
WINAPPNAME=$(VERSION)-Windows
WINBUNDLE=$(BUILDDIR)/$(WINAPPNAME)
WINPATCHDIR=$(WINBUNDLE)/bin

EXTRA=../README.md ../LICENSE.txt

.SILENT:

release:
	make clean
	make osx
	make win

osx:
	echo Making OSX app...
	cp -r $(BUILDDIR)/$(MACBASE) $(MACBUNDLE)
	cp -r $(PATCHDIR) $(MACPATCHDIR)
	cd $(BUILDDIR); zip -rq $(MACAPPNAME).zip $(MACAPPNAME).app $(EXTRA)
	echo done.

win:
	echo Making Windows fake app...
	cp -r $(BUILDDIR)/$(WINBASE) $(WINBUNDLE)
	cp -r $(PATCHDIR) $(WINPATCHDIR)
	cd $(BUILDDIR); zip -rq $(WINAPPNAME).zip $(WINAPPNAME) $(EXTRA)
	echo done.

clean:
	make cleanup
	rm -rf $(BUILDDIR)/*.zip ||:

cleanup:
	rm -rf $(MACBUNDLE) ||:
	rm -rf $(WINBUNDLE) ||:
