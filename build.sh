#/bin/bash
rm -rf build
mkdir build
cd build 
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../../polly/ios-11-0.cmake -GXcode
make