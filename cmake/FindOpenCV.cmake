# - Find OpenCV package for Windows.
#
# Inputs:
#  OPENCV_LOCATION          If defined, it will be searched first for OpenCV library.
#
# Outputs:
#  OPENCV_FOUND             Defined if a OpenCV is found.
#  OPENCV_VERSION           Version of detected OpenCV.
#
#  OPENCV_INCLUDE_DIRS      Path to OpenCV's include directories.
#
#  OPENCV_LIBRARIES         List of detected OpenCV libraries.

message(STATUS "============================")
message(STATUS "FindOpenCV")
message(STATUS "============================")

message(STATUS "OpenCV: location = ${OPENMESH_LOCATION}")

#=======================
# Version search list.
#=======================
set(_openMesh_VERSIONS)

foreach(major_version RANGE 3 2 -1)
    foreach(minor_version RANGE 5 1 -1)
        foreach(patch_version RANGE 9 1 -1)
            list(APPEND _opencv_VERSIONS "${major_version}.${minor_version}.${patch_version}")
        endforeach()
    endforeach()
endforeach()

set(_openMesh_SEARCH_VERSIONS)

if(OpenCV_FIND_VERSION_EXACT)
    # for e.g. find_package(OpenCV 3.2 EXACT)
    list(APPEND _openMesh_SEARCH_VERSIONS "${OpenCV_FIND_VERSION}")

else()
    if(OpenCV_FIND_VERSION)
        # for e.g. find_package(OpenCV 3.2)
        foreach(version ${_openMesh_VERSIONS})
            if(NOT "${version}" VERSION_LESS "${OpenCV_FIND_VERSION}")
                list(APPEND _openMesh_SEARCH_VERSIONS "${version}")
            endif()
        endforeach()

    else()
        # find_package(OpenCV REQUIRED)
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
find_path(OPENMESH_INCLUDE_DIRS OpenCV/Core
    PATHS ${_openMesh_SEARCH_PATHS}
    PATH_SUFFIXES
        include
    DOC "OpenCV: include")

message(STATUS "OpenCV: include = ${OPENMESH_INCLUDE_DIRS}")

if (OPENMESH_INCLUDE_DIRS)
    string(REGEX MATCH "[0-9].[0-9]" OPENMESH_VERSION "${OPENMESH_INCLUDE_DIRS}")
endif()
message(STATUS "OpenCV: version = ${OPENMESH_VERSION}")

if (OPENMESH_INCLUDE_DIRS)
    string(REGEX REPLACE "/include" "" OPENMESH_LOCATION "${OPENMESH_INCLUDE_DIRS}")
endif()

message(STATUS "OpenCV: location = ${OPENMESH_LOCATION}")

#=======================
# Find library directory.
#=======================

set(OPENMESH_LIBRARY_DIRS ${OPENMESH_LOCATION}/lib)

if(MSVC_ARCH STREQUAL "32")
    set(OPENMESH_LIBRARY_DIRS ${OPENMESH_LIBRARY_DIRS}/x86)
else()
    set(OPENMESH_LIBRARY_DIRS ${OPENMESH_LIBRARY_DIRS}/x64)
endif()

message(STATUS "OpenCV: library = ${OPENMESH_LIBRARY_DIRS}")

foreach(_openMesh_lib
    Core
    Tools)

    find_library(OPENMESH_${_openMesh_lib}_LIBRARY OpenCV${_openMesh_lib}
        PATHS ${OPENMESH_LIBRARY_DIRS}
        PATH_SUFFIXES lib
        DOC "OpenCV: ${OPENMESH_LIB} library")
    if (OPENMESH_${_openMesh_lib}_LIBRARY)
        message(STATUS "OpenCV: OPENMESH_${_openMesh_lib}_LIBRARY: ${OPENMESH_${_openMesh_lib}_LIBRARY}")
    endif()
    list(APPEND OPENMESH_LIBRARIES ${OPENMESH_${_openMesh_lib}_LIBRARY})
endforeach()

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenCV DEFAULT_MSG
    OPENMESH_INCLUDE_DIRS OPENMESH_LIBRARY_DIRS OPENMESH_VERSION)