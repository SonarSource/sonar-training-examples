#!/bin/bash
# set -x

if [ "$*" == "" ]; then
    # Build is the default option if not specified
    $0 build
    exit $?
fi

BUILDDIR="build"
for cmd in $*; do
    case $cmd in
        clean)
            rm -rf $BUILDDIR
            mkdir -p $BUILDDIR
            ;;
        build)
            # Build directly each file
            mkdir -p $BUILDDIR
            for file in src/*.cc; do
                target=$(basename $file .cc)
                g++ -Wall -c -o $BUILDDIR/$target.o $file
            done
            ;;
        clang-tidy)
            mkdir -p $BUILDDIR
        	clang-tidy -checks='*' -header-filter="^include" -p $BUILDDIR src/*.cc > $BUILDDIR/clang-tidy-report.txt
	        ./clang-tidy-to-sonar.py < $BUILDDIR/clang-tidy-report.txt > $BUILDDIR/generic-issue-report.json
            ;;
        comp-db)
            mkdir -p $BUILDDIR
            compiledb make --dry-run build-only
            mv compile_commands.json $BUILDDIR
            ./convert-compile-commands.py $BUILDDIR/compile_commands.json bw-output
            ;;
        *)
            echo "Usage: $0 [clean] [comp-db] [build] [clang-tidy]"
            echo "clean: Deletes all build artefacts"
            echo "comp-db: Creates a clang compilation database"
            echo "build: Builds the code"
            echo "clang-tidy: Runs clang-tidy and convert output to generic issue format"
            exit 0
            ;;
    esac
    shift
done

