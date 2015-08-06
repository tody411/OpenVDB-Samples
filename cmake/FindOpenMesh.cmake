# - Find OpenMesh package for Windows.
#
# Inputs:
#  OPENMESH_LOCATION          If defined, it will be searched first for OpenMesh library.
#
# Outputs:
#  OPENMESH_FOUND             Defined if a OpenMesh is found.
#  OPENMESH_VERSION           Version of detected OpenMesh (e.g. 3.2).
#
#  OPENMESH_INCLUDE_DIRS      Path to OpenMesh's include directories.
#
#  OPENMESH_LIBRARIES         List of detected OpenMesh libraries.
#  OPENMESH_Core_LIBRARY      OpenMesh Core library Path.
#  OPENMESH_Tools_LIBRARY     OpenMesh Tools library Path.


message(STATUS "============================")
message(STATUS "FindOpenMesh")
message(STATUS "============================")

message(STATUS "OpenMesh: location = ${OPENMESH_LOCATION}")

#=======================
# Version search list.
#=======================
set(_openMesh_VERSIONS)

foreach(major_version RANGE 4 3 -1)
    foreach(minor_version RANGE 5 1 -1)
        list(APPEND _openMesh_VERSIONS "${major_version}.${minor_version}")
    endforeach()
endforeach()

set(_openMesh_SEARCH_VERSIONS)

if(OpenMesh_FIND_VERSION_EXACT)
    # for e.g. find_package(OpenMesh 3.2 EXACT)
    list(APPEND _openMesh_SEARCH_VERSIONS "${OpenMesh_FIND_VERSION}")

else()
    if(OpenMesh_FIND_VERSION)
        # for e.g. find_package(OpenMesh 3.2)
        foreach(version ${_openMesh_VERSIONS})
            if(NOT "${version}" VERSION_LESS "${OpenMesh_FIND_VERSION}")
                list(APPEND _openMesh_SEARCH_VERSIONS "${version}")
            endif()
        endforeach()

    else()
        # find_package(OpenMesh REQUIRED)
        set(_openMesh_SEARCH_VERSIONS ${_openMesh_VERSIONS})
    endif()

endif()

#=======================
# Path search list.
#=======================
set(_openMesh_SEARCH_PATHS ${OPENMESH_LOCATION})

# Path search list from version search list.
#-----------------------
foreach(version ${_openMesh_SEARCH_VERSIONS})
    set(_openMesh_SEARCH_PATHS ${_openMesh_SEARCH_PATHS}
        "${OPENMESH_LOCATION}/${version}")
endforeach(version)

#=======================
# Find include directory.
#=======================
find_path(OPENMESH_INCLUDE_DIRS OpenMesh/Core
    PATHS ${_openMesh_SEARCH_PATHS}
    PATH_SUFFIXES
        include
    DOC "OpenMesh: include")

message(STATUS "OpenMesh: include = ${OPENMESH_INCLUDE_DIRS}")

if (OPENMESH_INCLUDE_DIRS)
    string(REGEX MATCH "[0-9].[0-9]" OPENMESH_VERSION "${OPENMESH_INCLUDE_DIRS}")
endif()
message(STATUS "OpenMesh: version = ${OPENMESH_VERSION}")

if (OPENMESH_INCLUDE_DIRS)
    string(REGEX REPLACE "/include" "" OPENMESH_LOCATION "${OPENMESH_INCLUDE_DIRS}")
endif()

message(STATUS "OpenMesh: location = ${OPENMESH_LOCATION}")

#=======================
# Find library directory.
#=======================

set(OPENMESH_LIBRARY_DIRS ${OPENMESH_LOCATION}/lib)

if(MSVC_ARCH STREQUAL "32")
    set(OPENMESH_LIBRARY_DIRS ${OPENMESH_LIBRARY_DIRS}/x86)
else()
    set(OPENMESH_LIBRARY_DIRS ${OPENMESH_LIBRARY_DIRS}/x64)
endif()

message(STATUS "OpenMesh: library = ${OPENMESH_LIBRARY_DIRS}")

foreach(_openMesh_lib
    Core
    Tools)

    find_library(OPENMESH_${_openMesh_lib}_LIBRARY OpenMesh${_openMesh_lib}
        PATHS ${OPENMESH_LIBRARY_DIRS}
        PATH_SUFFIXES lib
        DOC "OpenMesh: ${OPENMESH_LIB} library")
    if (OPENMESH_${_openMesh_lib}_LIBRARY)
        message(STATUS "OpenMesh: OPENMESH_${_openMesh_lib}_LIBRARY: ${OPENMESH_${_openMesh_lib}_LIBRARY}")
    endif()
    list(APPEND OPENMESH_LIBRARIES ${OPENMESH_${_openMesh_lib}_LIBRARY})
endforeach()

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenMesh DEFAULT_MSG
    OPENMESH_INCLUDE_DIRS OPENMESH_LIBRARY_DIRS OPENMESH_VERSION)