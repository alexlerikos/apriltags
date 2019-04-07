#/bin/bash
export POLLY_IOS_DEVELOPMENT_TEAM="BCZNDS34S5"

rm -rf build
mkdir build
cd build 
pwd
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../cmake_files/ios_cmake.cmake -GXcode
make