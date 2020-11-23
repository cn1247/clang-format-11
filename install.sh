#!/bin/bash
#
# use llvm 11 release code and compile it

sudo apt install cmake

ls *.xz | xargs -n1 tar xvJf
mv clang-11.0.0.src clang
mv clang/ llvm-11.0.0.src/tools/
mv clang-tools-extra-11.0.0.src extra
mv extra/ llvm-11.0.0.src/tools/clang/tools/
mv compiler-rt-11.0.0.src compiler-rt
mv compiler-rt llvm-11.0.0.src/projects/
cd llvm-11.0.0.src || exit 1
mkdir build_11.0.0 && cd build_11.0.0 || exit 1

cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-static-libgcc" \
-DCMAKE_CXX_FLAGS="-static-libgcc -static-libstdc++"
ninja clang-format
sudo mkdir /opt/clang-format-11
sudo cp -rf bin/* /opt/clang-format-11
sudo ln -snf /opt/clang-format-11/clang-format /usr/bin/clang-format
