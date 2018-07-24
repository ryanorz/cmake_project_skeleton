cmake_minimum_required(VERSION 3.0)

project(example LANGUAGES CXX VERSION 0.0.2)

#
# Build Options
#
option(SanitizeAddress "compile with -fsanitize=address"    OFF)
option(BUILD_TESTS     "Build test program."                ON)
option(BUILD_COVERAGE  "Coverage specific configuration"    ON)

include("${CMAKE_SOURCE_DIR}/cmake/configuration.cmake")

message("${Blue}-- SanitizeAddress..........${SanitizeAddress}${Reset}")
message("${Blue}-- BUILD_TESTS..............${BUILD_TESTS}${Reset}")
message("${Blue}-- BUILD_COVERAGE...........${BUILD_COVERAGE}${Reset}")

######################################################################
# Configuration
######################################################################
if(BUILD_COVERAGE)
  set(CMAKE_BUILD_TYPE Coverage)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -Wall -fprofile-arcs -ftest-coverage -Qunused-arguments")
  set(LCOV_REMOVE_EXTRA "'test/*'" "'dependency/*'")
endif()

#set(CMAKE_INSTALL_PREFIX /usr)
include(GNUInstallDirs)
message("${Blue}-- CMAKE_INSTALL_PREFIX.....${CMAKE_INSTALL_PREFIX}${Reset}")
if(SanitizeAddress)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")
endif()

######################################################################
# Dependencies
######################################################################
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules")

include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/src)
include_directories(${CMAKE_SOURCE_DIR}/dependency)

if(BUILD_COVERAGE)
  include(CodeCoverage)
endif()
find_package(PkgConfig REQUIRED)
# set PKG_CONFIG_PATH value is a bug of cmake, and it was fixed in 3df5147043d83aa09acd5c9ce31d5c602efb99db
# set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${MYLIB_ROOT}/lib/pkgconfig")
# set(CMAKE_FIND_ROOT_PATH "/usr")

#set(Boost_USE_STATIC_LIBS OFF)
#set(Boost_USE_MULTITHREADED OFF)
#set(Boost_USE_STATIC_RUNTIME OFF)
#find_package(Boost REQUIRED COMPONENTS system filesystem)
#include_directories(${Boost_INCLUDE_DIRS})

#pkg_check_modules(examplexx REQUIRED examplexx)
#include_directories(${examplexx_INCLUDE_DIRS})
#link_directories(${examplexx_LIBRARY_DIRS})

#find_package(examplexxx REQUIRED)
#include_directories(${examplexxx_INCLUDE_DIR})
#link_directories(${examplexxx_LIBRARY_DIRS})

######################################################################
# Source Code directory
######################################################################

add_subdirectory(src)

######################################################################
# Test
######################################################################
if(BUILD_TESTS)
  find_package(catch2 REQUIRED)
  include_directories(${catch2_INCLUDE_DIR})
  enable_testing()
  file(GLOB_RECURSE test_src test/*.cc)
  add_executable( unit_tests ${test_src} )
  add_test(NAME unit_tests
      COMMAND unit_tests
  )
  if(BUILD_COVERAGE)
    setup_target_for_coverage(unit_tests_coverage unit_tests coverage)
  endif()
endif()

