NAME=upfind
VERSION=0.0.1

DIRS=bin share
INSTALL_DIRS=$(shell find $(DIRS) -type d 2>/dev/null)
INSTALL_FILES=$(shell find $(DIRS) -type f 2>/dev/null)
DOC_FILES=$(wildcard *.md *.txt)

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG_DIR)/$(PKG_NAME).asc

PREFIX?=/usr/local
DOC_DIR=$(PREFIX)/share/doc/$(PKG_NAME)

MAN_SECTION ?= 1
MAN_DIR = share/man/man$(MAN_SECTION)
MAN = $(MAN_DIR)/$(NAME).$(MAN_SECTION).gz

build: $(MAN) $(PKG)

all: $(MAN) $(PKG) $(SIG)

pkg:
	mkdir -p $(PKG_DIR)

$(PKG): pkg
	git archive --output=$(PKG) --prefix=$(PKG_NAME)/ HEAD

man:
	mkdir -p $(MAN_DIR)

$(MAN): man
	help2man --name="$(shell bin/$(NAME) -h 2>&1 | head -n 1)" \
		 --no-discard-stderr \
		 --help-option=-h \
		 --version-string=$(VERSION) \
			bin/$(NAME) | gzip -9 > $@

sign: $(SIG)

$(SIG): $(PKG)
	gpg --sign --detach-sign --armor $(PKG)

clean:
	$(RM) $(MAN) $(PKG) $(SIG)

veryclean: clean
	$(RM) -r -d $(MAN_DIR)

test:
	$(info Target `$@` not implemented yet)

tag:
	git tag v$(VERSION)
	git push --tags

release: $(PKG) $(SIG) tag

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(PREFIX)/$$file; done
	mkdir -p $(DOC_DIR)
	cp -r $(DOC_FILES) $(DOC_DIR)/

uninstall:
	for file in $(INSTALL_FILES); do $(RM) $(PREFIX)/$$file; done
	$(RM) $(DOC_DIR)

.PHONY: build sign man clean veryclean test tag release install uninstall all
