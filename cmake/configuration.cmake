# Copyright 2013-2017, Corvusoft Ltd, All Rights Reserved.

if( NOT WIN32 )
    string( ASCII 27 Esc )

    set( Reset   "${Esc}[m"   )
    set( Red     "${Esc}[31m" )
    set( Blue    "${Esc}[34m" )
    set( Green   "${Esc}[32m" )
    set( Yellow  "${Esc}[33m" )
endif( )

if ( BUILD_SHARED )
    set( BUILD_SHARED_LIBS ON )
endif ( )

set( INCLUDE_DIR "${CMAKE_SOURCE_DIR}/src" )
set( SOURCE_DIR "${INCLUDE_DIR}" )

message(CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID})

if ( ${CMAKE_CXX_COMPILER_ID} STREQUAL GNU )
    if ( ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 4.8 )
        message( FATAL_ERROR "\nGCC version < 4.8\nYour systems default compiler is GCC. This project makes use of c++11 features present only in versions of gcc >= 4.8. You can use a different compiler by re-running cmake with the command switch \"-D CMAKE_CXX_COMPILER=<compiler>\" " )
    else ( )
        set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-non-virtual-dtor" )
    endif ( )
elseif( ${CMAKE_CXX_COMPILER_ID} STREQUAL Clang OR ${CMAKE_CXX_COMPILER_ID} STREQUAL AppleClang)
    if ( ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 3.3 )
        message( FATAL_ERROR "\nClang version < 3.3\nYour systems default compiler is clang. This project makes use of c++11 features present only in versions of clang >= 3.3. You can use a different compiler by re-running cmake with the command switch \"-D CMAKE_CXX_COMPILER=<compiler>\" " )
    else ( )
        set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" )
    endif ( )
elseif( ${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC )
    if ( ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 19.00.23026.0 )
        message( WARNING "\nMSVC compiler version < 19.00.23026.0" )
    endif ( )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /D_WIN32_WINNT=0x0601 /W4 /wd4068 /wd4702" )
else ( )
    message( FATAL_ERROR "Compiler not supported.")
endif ( )

if( NOT WIN32 )
    if ( CMAKE_BUILD_TYPE MATCHES Debug )
        set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O0 -Wall -Wextra -Weffc++ -pedantic -Wno-unknown-pragmas" )
    else ( )
        string( REPLACE "-O3" "" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}" )
        set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O2 -Wall -Wextra -Weffc++ -pedantic -Wno-unknown-pragmas" )
    endif ( )
endif ( )

if ( UNIX AND NOT APPLE )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread" )
endif ( )

if ( APPLE )
    set( CMAKE_MACOSX_RPATH ON )
endif ( )

