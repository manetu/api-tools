TOOLS += manetu-graphql-cli
TOOLS += manetu-sparql-cli

BINDIR ?= /usr/local/bin

install:
	cp $(TOOLS) $(BINDIR)
