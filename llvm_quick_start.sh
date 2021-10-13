#!/bin/bash

# llvm quick-start tool [Created for MacOS cuild be used on Linux]
# Owner: github/alexgiving
# Year: 2021

if [ -z $* ]; then
    echo "No options found!"
    echo "Use -h to help"
    exit 1
fi

echo "Quick-start tool for llvm project is started..."
cd ../llvm-project/
WORKDIR=$(PWD)
BUILD_DIR=${WORKDIR}/build
echo "WORKDIR is changed to" ${WORKDIR}

while getopts "ibth" opt; do
  case "$opt" in
    h) # Help
        echo "Help:"
        echo "-i install all required packages"
        echo "-b build llvm project to " ${BUILD_DIR}
        echo "-t run llvm project from " ${BUILD_DIR}
        ;;
    i) # Install packages
        echo "Get brew package system"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        echo "Install ninja package"
        brew install ninja

        echo "Install cmake package"
        brew install cmake

        echo "Install llvm clang package"
        brew install llvm

        echo "Set required paths"
        export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
        export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
        ;;
    b) # Build
        echo "Prepare a build"
        mkdir -p build
        cd ${BUILD_DIR}
        cmake -G "Ninja" -DLLVM_ENABLE_PROJECTS=clang -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="host" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_RTTI=ON ../llvm
        ;;
t) # Run ninja
        echo "Run ninja"
        if test -d "$BUILD_DIR"; then
            cd $BUILD_DIR
        fi
            ninja
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&4
        ;;
  esac
done
