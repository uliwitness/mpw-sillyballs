SOURCES=SillyBalls.c
RFILES=SillyBalls.r Size.r
EXECUTABLE=SillyBalls
CREATOR='SILB'

BIN_DIR=~/Programming/mpw/build/bin
LD=$(BIN_DIR)/mpw link
REZ=$(BIN_DIR)/mpw Rez
CC=$(BIN_DIR)/mpw SC
RINCLUDES={RIncludes}/

LDFLAGS=-w -c $(CREATOR) -t APPL \
	-sn STDIO=Main -sn INTENV=Main -sn %A5Init=Main

LIBRARIES={Libraries}Stubs.o \
	{Libraries}MacRuntime.o \
	{Libraries}IntEnv.o \
	{Libraries}Interface.o \
	{Libraries}ToolLibs.o \
	{CLibraries}StdCLib.o

TOOLBOXFLAGS=-d OLDROUTINENAMES=1 -typecheck relaxed

OBJECTS=$(SOURCES:%.c=build/obj/%.o)

all: prepass build/$(EXECUTABLE)

prepass:
	mkdir -p build build/obj

build/$(EXECUTABLE): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) $(LIBRARIES) -o $@
	$(REZ) -rd $(RFILES) -o $@ -i $(RINCLUDES) -append

build/obj/%.o : %.c
	$(CC) $(TOOLBOXFLAGS) $< -o $@

clean:
	rm -rf build/obj build
