# - Try to find catch ( catch.hpp )
# Once done, this will define
#
# catch_FOUND - system has catch
# catch_INCLUDE_DIR - the catch include directories

include("LibFindMacros")

# Include dir
find_path(catch_INCLUDE_DIR
  NAMES catch.hpp
  PATHS "${CMAKE_SOURCE_DIR}/test" "/usr/include" "/usr/local/include" "/opt/local/include"
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(catch_PROCESS_INCLUDES catch_INCLUDE_DIR)
libfind_process(catch)
