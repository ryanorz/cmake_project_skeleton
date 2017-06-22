# - Try to find example ( libexample.so )
# Once done, this will define
#
# example_FOUND - system has example
# example_INCLUDE_DIR - the example include directories
# example_LIBRARIES - link these to use example

include("LibFindMacros")

# Dependencies
find_package(example_dependency REQUIRED)

# Use pkg-config to get hints about paths
libfind_pkg_check_modules(example_PKGCONF example)

# Include dir
find_path(example_INCLUDE_DIR
  NAMES example.h
  PATHS ${example_PKGCONF_INCLUDE_DIRS}
)

# Finally the library itself
find_library(example_LIBRARY
  NAMES example example NAMES_PER_DIR
  PATHS ${example_PKGCONF_LIBRARY_DIRS}
)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(example_PROCESS_INCLUDES example_INCLUDE_DIR)
set(example_PROCESS_LIBS example_LIBRARY example_dependency_LIBRARY)
libfind_process(example)

