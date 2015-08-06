# - Setup External Libraries for Windows.
#
#  Since Windows environment lacks the package manager,
#  I usually manage external libraries in <EXT_LIB_ROOT> directory.
#  Directory structures of <EXT_LIB_ROOT>:
#   - <EXT_LIB_ROOT>
#     - <LIBNAME1>: Library name (e.g. Eigen, OpenMesh, ... etc).
#       - <VERSION1>: Version number (e.g. 3.2.1)
#           - <INCLUDE>: Include directory for .h files.
#           - <LIB>: Library directory for .lib, .dll files.
#       - <VERSION2>
#     - <LIBNAME2>
#
# Inputs:
#  EXT_LIB_ROOT          Environment variables for the root directory which includes external libraries.
#
# Outputs:
#  EIGEN_LOCATION        Eigen library location.
#  OPENMESH_LOCATION     OpenMesh library location.

# Set library location for target name.
# Inputs:
#  - target:                    library name (directory name). e.g. Eigen.
# Outputs:
#  - UPPER(<target>)_LOCATION   library location. e.g. EIGEN_LOCATION.
#-----------------------
macro(_set_lib_location  target)
    string(TOUPPER ${target}_LOCATION _lib_LOCATION_NAME)
    find_path(${_lib_LOCATION_NAME} ${target}
    PATHS $ENV{EXT_LIB_ROOT}
    DOC "${_lib_LOCATION_NAME}")

    if (${_lib_LOCATION_NAME})
        set(${_lib_LOCATION_NAME} $ENV{EXT_LIB_ROOT}/${target})
        message(STATUS "${_lib_LOCATION_NAME} = ${${_lib_LOCATION_NAME}}")
    else ()
        set(_lib_LOCATION $ENV{EXT_LIB_ROOT}/${target})
        message(WARNING "Failed to set ${_lib_LOCATION_NAME}")
        message(STATUS "WARNING: Failed to set ${_lib_LOCATION_NAME}")
        message(STATUS "  Please locate ${target} library directory in ${_lib_LOCATION}")
    endif()

    #set(_lib_LOCATION $ENV{EXT_LIB_ROOT}/${target})
    #set(${_lib_LOCATION_NAME} ${_lib_LOCATION})

endmacro(_set_lib_location)

message(STATUS "============================")
message(STATUS "SetupExtLibs")
message(STATUS "============================")
message(STATUS "EXT_LIB_ROOT = $ENV{EXT_LIB_ROOT}")


_set_lib_location(Eigen)
_set_lib_location(OpenMesh)
_set_lib_location(OpenVDB)
_set_lib_location(boost)
_set_lib_location(zlib)
_set_lib_location(IlmBase)
_set_lib_location(tbb43)

message(STATUS "")


