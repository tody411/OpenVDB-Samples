# - Find boost package for Windows.
#
# Inputs:
#  BOOST_LOCATION          If defined, it will be searched first for boost library.
#
# Outputs:
#  BOOST_FOUND             Defined if a boost is found.
#  BOOST_VERSION           Version of detected boost (e.g. 3.0.0).
#
#  BOOST_INCLUDE_DIRS      Path to boost's include directories.
#
#  BOOST_LIBRARIES         List of detected boost libraries.
#  BOOST_openvdb_LIBRARY   boost openvdb library Path.


include(UtilFindLib)

UTIL_OUTPUT_HEADER(boost)
set(_boost_VERSIONS "1.58.0" "1.57.0" "1.56.0")
UTIL_FIND_LOCATION(boost _boost_VERSIONS "include/boost" BOOST_LOCATION)

UTIL_FIND_INCLUDE_DIRS(boost BOOST_INCLUDE_DIRS)
UTIL_FIND_LIBRARY_DIRS(boost BOOST_LIBRARY_DIRS)
set(_boost_LIBRARIES "libboost_system-vc110-mt-1_57")
#UTIL_FIND_LIBRARIES(boost _boost_LIBRARIES BOOST_LIBRARIES)

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(boost DEFAULT_MSG
    BOOST_LOCATION BOOST_INCLUDE_DIRS BOOST_LIBRARY_DIRS )