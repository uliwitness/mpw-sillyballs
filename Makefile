SOURCES=SillyBalls.c
RFILES=SillyBalls.r Size.r
EXECUTABLE=SillyBalls

RINCLUDES=~/mpw/Interfaces/RIncludes

LDFLAGS=-w -c 'SILB' -t APPL \
	-sn STDIO=Main -sn INTENV=Main -sn %A5Init=Main

LIBRARIES={Libraries}Stubs.o \
	{Libraries}MacRuntime.o \
	{Libraries}IntEnv.o \
	{Libraries}Interface.o \
	{Libraries}ToolLibs.o \
	{CLibraries}StdCLib.o

TOOLBOXFLAGS=-d OLDROUTINENAMES=1 -typecheck relaxed

OBJECTS=$(SOURCES:%.c=obj/%.o)

all: prepass bin/$(EXECUTABLE)

prepass:
	mkdir -p obj bin

bin/$(EXECUTABLE): $(OBJECTS)
	~/Programming/mpw/build/bin/mpw link $(LDFLAGS) $(OBJECTS) $(LIBRARIES) -o $@
	Rez -rd $(RFILES) -o $@ -i $(RINCLUDES) -append

obj/%.o : %.c
	./sc.sh $(TOOLBOXFLAGS) $< -o $@

clean:
	rm -rf bin obj
