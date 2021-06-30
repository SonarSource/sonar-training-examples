CC=g++
CFLAGS=-Wall

SRCDIR   = src
BUILDDIR   = build

SOURCES  := $(wildcard $(SRCDIR)/*.cc)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cc=$(BUILDDIR)/%.o)

all: clean comp-db $(OBJECTS)

$(OBJECTS): $(BUILDDIR)/%.o : $(SRCDIR)/%.cc
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILDDIR)/* compile_commands.json

clang-tidy:
	clang-tidy -checks='*' -header-filter="^include" src/*.cc -p $(BUILDDIR) > $(BUILDDIR)/clang-tidy-report.txt
	./clang-tidy-to-sonar.py < $(BUILDDIR)/clang-tidy-report.txt > $(BUILDDIR)/generic-issue-report.json

comp-db:
	compiledb make --dry-run build-only
	mv compile_commands.json $(BUILDDIR)
	./convert-compile-commands.py build/compile_commands.json bw-output

build-only: clean $(OBJECTS)