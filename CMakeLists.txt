cmake_minimum_required(VERSION 2.8)

project(example)
set(example_VERSION_MAJOR 0)
set(example_VERSION_MINOR 0)
set(example_VERSION_PATCH 1)
set(example_VERSION ${example_VERSION_MAJOR}.${example_VERSION_MINOR}.${example_VERSION_PATCH})
set(PACKAGE_VERSION ${example_VERSION})
set(VERSION "${example_VERSION}")

#
# Build Options
#
option(SanitizeAddress "compile with -fsanitize=address"    OFF)
option(BUILD_TESTS     "Build test program."                ON)

include("${CMAKE_SOURCE_DIR}/cmake/configuration.cmake")

message("${Blue}-- SanitizeAddress..........${SanitizeAddress}${Reset}")
message("${Blue}-- BUILD_TESTS..............${BUILD_TESTS}${Reset}")

######################################################################
# Configuration
######################################################################
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
  set(catch_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/dependency/catch")
  include_directories(${catch_INCLUDE_DIR})
  enable_testing()
  add_subdirectory("${CMAKE_SOURCE_DIR}/test/unit")
  add_subdirectory("${CMAKE_SOURCE_DIR}/test/integration")
endif()

