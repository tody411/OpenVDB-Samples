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
#  OPENCV_RELEASE_LIBRARIES List of detected OpenCV release libraries.
#  OPENCV_DEBUG_LIBRARIES   List of detected OpenCV debug libraries.

message(STATUS "============================")
message(STATUS "FindOpenCV")
message(STATUS "============================")

message(STATUS "OpenCV: location = ${OPENCV_LOCATION}")

#=======================
# Version search list.
#=======================
set(_opencv_VERSIONS)

foreach(major_version RANGE 3 2 -1)
    foreach(minor_version RANGE 5 1 -1)
        foreach(patch_version RANGE 9 1 -1)
            list(APPEND _opencv_VERSIONS "${major_version}.${minor_version}.${patch_version}")
        endforeach()
    endforeach()
endforeach()

set( _opencv_SEARCH_VERSIONS)

if(OpenCV_FIND_VERSION_EXACT)
    # for e.g. find_package(OpenCV 2.4.9 EXACT)
    list(APPEND _opencv_SEARCH_VERSIONS "${OpenCV_FIND_VERSION}")

else()
    if(OpenCV_FIND_VERSION)
        # for e.g. find_package(OpenCV 2.4.9)
        foreach(version ${_opencv_VERSIONS})
            if(NOT "${version}" VERSION_LESS "${OpenCV_FIND_VERSION}")
                list(APPEND _opencv_SEARCH_VERSIONS "${version}")
            endif()
        endforeach()

    else()
        # find_package(OpenCV REQUIRED)
        set(_opencv_SEARCH_VERSIONS ${_opencv_VERSIONS})
    endif()

endif()

#=======================
# Path search list.
#=======================
set(_opencv_SEARCH_PATHS "${OPENCV_LOCATION}" "C:/opencv")

# Path search list from version search list.
#-----------------------
foreach(version ${_opencv_SEARCH_VERSIONS})
    set(_opencv_SEARCH_PATHS ${_opencv_SEARCH_PATHS}
        "C:/opencv/${version}")
endforeach(version)

#=======================
# Find include directory.
#=======================
find_path(OPENCV_INCLUDE_DIRS opencv2/opencv.hpp
    PATHS ${_opencv_SEARCH_PATHS}
    PATH_SUFFIXES
        build/include
    DOC "OpenCV: include")

message(STATUS "OpenCV: include = ${OPENCV_INCLUDE_DIRS}")

if (OPENCV_INCLUDE_DIRS)
    string(REGEX MATCH "[0-9].[0-9].[0-9]" OPENCV_VERSION "${OPENCV_INCLUDE_DIRS}")
endif()
message(STATUS "OpenCV: version = ${OPENCV_VERSION}")

if (OPENCV_INCLUDE_DIRS)
    string(REGEX REPLACE "/include" "" OPENCV_LOCATION "${OPENCV_INCLUDE_DIRS}")
endif()

message(STATUS "OpenCV: location = ${OPENCV_LOCATION}")

#=======================
# Find library directory.
#=======================
if(MSVC_ARCH STREQUAL "32")
    set(OPENCV_LIBRARY_DIRS ${OPENCV_LOCATION}/x86)
else()
    set(OPENCV_LIBRARY_DIRS ${OPENCV_LOCATION}/x64)
endif()

set(OPENCV_LIBRARY_DIRS ${OPENCV_LIBRARY_DIRS}/vc${MSVC_TOOL_VERSION}/lib)

message(STATUS "OpenCV: library = ${OPENCV_LIBRARY_DIRS}")

file(GLOB OPENCV_RELEASE_LIBRARIES "${OPENCV_LIBRARY_DIRS}/*[0-9][0-9][0-9].lib")
file(GLOB OPENCV_DEBUG_LIBRARIES "${OPENCV_LIBRARY_DIRS}/*[0-9][0-9][0-9]d.lib")

set(OPENCV_LIBRARIES ${OPENCV_RELEASE_LIBRARIES})
message(STATUS "OpenCV: libraries = ${OPENCV_LIBRARIES}")

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenCV DEFAULT_MSG
    OPENCV_INCLUDE_DIRS OPENCV_LIBRARY_DIRS OPENCV_VERSION)