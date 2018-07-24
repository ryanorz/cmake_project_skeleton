# cmake_project_skeleton

[![Build Status](https://travis-ci.org/ryanorz/cmake_project_skeleton.svg?branch=master)](https://travis-ci.org/ryanorz/cmake_project_skeleton)

Cmake modules use [LibFindMacros.cmake](https://cmake.org/Wiki/CMake:How_To_Find_Libraries)

Test framework use [Catch2](https://github.com/catchorg/Catch2)

Mock framework use [FakeIt](https://github.com/eranpeer/FakeIt)

[cmake_catch_coverage](https://github.com/fkromer/catch_cmake_coverage)

# Setup
Integration of CMake, Catch and CMake CodeCoverage module for C++ code. (CMake CodeCoverage depends on: gcov, gcovr, genhtml, lcov.)

# Usage

```
mkdir build
cd build
make 
make test

./unit_tests

make unit_tests_coverage
xdg-open ./coverage/index.html
```
