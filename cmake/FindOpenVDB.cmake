# - Find OpenVDB package for Windows.
#
# Inputs:
#  OPENVDB_LOCATION          If defined, it will be searched first for OpenVDB library.
#
# Outputs:
#  OPENVDB_FOUND             Defined if a OpenVDB is found.
#  OPENVDB_VERSION           Version of detected OpenVDB (e.g. 3.0.0).
#
#  OPENVDB_INCLUDE_DIRS      Path to OpenVDB's include directories.
#
#  OPENVDB_LIBRARIES         List of detected OpenVDB libraries.
#  OPENVDB_openvdb_LIBRARY   OpenVDB openvdb library Path.


include(UtilFindLib)

UTIL_OUTPUT_HEADER(OpenVDB)
set(_openvdb_VERSIONS 3.0.0)
UTIL_FIND_LOCATION(OpenVDB _openvdb_VERSIONS "include/openvdb")

UTIL_FIND_INCLUDE_DIRS(OpenVDB)
UTIL_FIND_LIBRARY_DIRS(OpenVDB)
set(_openvdb_LIBRARIES openvdb)
UTIL_FIND_LIBRARIES(OpenVDB _openvdb_LIBRARIES)

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenVDB DEFAULT_MSG
    OPENVDB_LOCATION OPENVDB_INCLUDE_DIRS OPENVDB_LIBRARY_DIRS )