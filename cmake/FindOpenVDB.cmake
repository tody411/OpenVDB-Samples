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
#  OPENVDB_LIBRARY_DIRS
#  OPENVDB_LIBRARIES         List of detected OpenVDB libraries.
#  OPENVDB_openvdb_LIBRARY   OpenVDB openvdb library Path.


include(UtilFindLib)

UTIL_OUTPUT_HEADER(OpenVDB)
set(_openvdb_VERSIONS "3.0.0")
UTIL_FIND_LOCATION(OpenVDB _openvdb_VERSIONS "include/openvdb" OPENVDB_LOCATION)

UTIL_FIND_INCLUDE_DIRS(OpenVDB OPENVDB_INCLUDE_DIRS)
UTIL_FIND_LIBRARY_DIRS(OpenVDB OPENVDB_LIBRARY_DIRS)

set(_openvdb_LIBRARIES "openvdb")
UTIL_FIND_LIBRARIES(OpenVDB _openvdb_LIBRARIES OPENVDB_LIBRARIES)

UTIL_OUTPUT_HEADER(zlib)
UTIL_FIND_LOCATION(zlib "" "include/zlib.h" ZLIB_LOCATION)
UTIL_FIND_INCLUDE_DIRS(zlib ZLIB_INCLUDE_DIRS)
UTIL_FIND_LIBRARY_DIRS(zlib ZLIB_LIBRARY_DIRS)
set(_zlib_LIBRARIES "zlib")
UTIL_FIND_LIBRARIES(zlib _zlib_LIBRARIES ZLIB_LIBRARIES)
set(_zlib_DLLS "zlib")
UTIL_FIND_DLLS(zlib _zlib_DLLS ZLIB_DLLS)

UTIL_OUTPUT_HEADER(IlmBase)
UTIL_FIND_LOCATION(IlmBase "" "include/IlmBaseConfig.h" ILMBASE_LOCATION)
UTIL_FIND_INCLUDE_DIRS(IlmBase ILMBASE_INCLUDE_DIRS)
UTIL_FIND_LIBRARY_DIRS(IlmBase ILMBASE_LIBRARY_DIRS)
set(_IlmBase_LIBRARIES "Half")
UTIL_FIND_LIBRARIES(IlmBase _IlmBase_LIBRARIES ILMBASE_LIBRARIES)

UTIL_OUTPUT_HEADER(tbb43)
UTIL_FIND_LOCATION(tbb43 "" "include/tbb" TBB43_LOCATION)
UTIL_FIND_INCLUDE_DIRS(tbb43 TBB43_INCLUDE_DIRS)
UTIL_FIND_LIBRARY_DIRS(tbb43 TBB43_LIBRARY_DIRS)
set(_tbb43_LIBRARIES "tbb")
UTIL_FIND_LIBRARIES(tbb43 _tbb43_LIBRARIES TBB43_LIBRARIES)

set(OPENVDB_INCLUDE_DIRS ${OPENVDB_INCLUDE_DIRS} ${ZLIB_INCLUDE_DIRS} ${ILMBASE_INCLUDE_DIRS} ${TBB43_INCLUDE_DIRS})
set(OPENVDB_LIBRARY_DIRS ${OPENVDB_LIBRARY_DIRS} ${ZLIB_LIBRARY_DIRS} ${ILMBASE_LIBRARY_DIRS} ${TBB43_LIBRARY_DIRS})
set(OPENVDB_LIBRARIES ${OPENVDB_LIBRARIES} ${ZLIB_LIBRARIES} ${ILMBASE_LIBRARIES} ${TBB43_LIBRARIES})
set(OPENVDB_DLLS ${OPENVDB_DLLS} ${ZLIB_DLLS} ${ILMBASE_DLLS} ${TBB43_DLLS})

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenVDB DEFAULT_MSG
    OPENVDB_LOCATION OPENVDB_INCLUDE_DIRS OPENVDB_LIBRARY_DIRS )