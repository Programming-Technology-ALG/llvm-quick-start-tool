#!/bin/bash

# llvm quick-start tool [tested on MacOS 11.5.2]
# Owner: github/alexgiving
# Year: 2021

if [ -z $* ]; then
	echo "No options found!"
	echo "Use -h to help"
	exit 1
fi

echo "Quick-start tool for llvm proqect is started..."

while getopts "ibth" opt; do
  case "$opt" in
  	h) # Help
    	echo "Help:"
    	echo "-i install all required packages"
    	echo "-b build llvm project to {llvm_folder}/build"
    	echo "-t test llvm project from {llvm_folder}/build directory"
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
		;;
    b) # Build
		echo "Prepare a build"
		mkdir build
		cd build
		cmake -G "Ninja" -DLLVM_ENABLE_PROJECTS=clang -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="host" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_RTTI=ON ../llvm
      	;;
    t) # Run ninja tests
		echo "Run ninja test"
    	ninja
      	;;
    \?)
	    echo "Invalid option: -$OPTARG" >&2
	    ;;
  esac
done