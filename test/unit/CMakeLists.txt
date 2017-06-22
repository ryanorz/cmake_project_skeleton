#
# Configuration
#
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_REENTRANT -D_GNU_SOURCE")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64")

#
# Build
#
add_executable( example_test_suite example_suite.cc )
add_test(NAME example_test_suite
    COMMAND example_test_suite
)

