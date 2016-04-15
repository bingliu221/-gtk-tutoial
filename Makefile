CC = gcc
PKGCONFIG = $(shell which pkg-config)
CFLAGS = $(shell $(PKGCONFIG) --cflags gtk+-3.0)
LIBS = $(shell $(PKGCONFIG) --libs gtk+-3.0)
GLIB_COMPILE_RESOURCES = $(shell $(PKGCONFIG) --variable=glib_compile_resources gio-2.0)
GLIB_COMPILE_SCHEMAS = $(shell $(PKGCONFIG) --variable=glib_compile_schemas gio-2.0)

SRC = exampleapp.c exampleappwin.c exampleappprefs.c main.c
BUILT_SRC = resources.c

OBJS = $(SRC:.c=.o) $(BUILT_SRC:.c=.o)

all: exampleapp

net.bingliu.exampleapp.gschema.valid: net.bingliu.exampleapp.gschema.xml
	$(GLIB_COMPILE_SCHEMAS) --strict --dry-run --schema-file=$< && mkdir -p $(@D) && touch $@

gschemas.compiled: net.bingliu.exampleapp.gschema.valid
	$(GLIB_COMPILE_SCHEMAS) .

resources.c: exampleapp.gresource.xml window.ui app-menu.ui prefs.ui
	$(GLIB_COMPILE_RESOURCES) exampleapp.gresource.xml --target=$@ --sourcedir=. --generate-source

%.o: %.c
	$(CC) -c -o $(@F) $(CFLAGS) $<

exampleapp: $(OBJS) gschemas.compiled
	$(CC) -o $(@F) $(OBJS) $(LIBS)

clean:
	rm -f net.bingliu.exampleapp.gschema.valid
	rm -f gschemas.compiled
	rm -f $(BUILT_SRC)
	rm -f $(OBJS)
	rm -f exampleapp
