# - Find Eigen package for Windows.
#
# Inputs:
#  EIGEN_LOCATION          If defined, it will be searched first for Eigen library.
#
# Outputs:
#  EIGEN_FOUND             Defined if a Eigen is found.
#  EIGEN_VERSION           Version of detected Eigen (e.g. 3.2.1).
#
#  EIGEN_INCLUDE_DIRS      Path to Eigen's include directories.

message(STATUS "============================")
message(STATUS "FindEigen")
message(STATUS "============================")

message(STATUS "Eigen: location = ${EIGEN_LOCATION}")

#=======================
# Version search list.
#=======================
set(_eigen_VERSIONS)

foreach(major_version RANGE 3 2 -1)
    foreach(minor_version RANGE 3 1 -1)
        foreach(patch_version RANGE 5 1 -1)
            list(APPEND _eigen_VERSIONS "${major_version}.${minor_version}.${patch_version}")
        endforeach()
    endforeach()
endforeach()

set(_eigen_SEARCH_VERSIONS)

if(Eigen_FIND_VERSION_EXACT)
    # for e.g. find_package(Eigen 3.2.1 EXACT)
    list(APPEND _eigen_SEARCH_VERSIONS "${Eigen_FIND_VERSION}")

else()
    if(Eigen_FIND_VERSION)
        # for e.g. find_package(Eigen 3.2.1)
        foreach(version ${_eigen_VERSIONS})
            if(NOT "${version}" VERSION_LESS "${Eigen_FIND_VERSION}")
                list(APPEND _eigen_SEARCH_VERSIONS "${version}")
            endif()
        endforeach()

    else()
        # find_package(Eigen REQUIRED)
        set(_eigen_SEARCH_VERSIONS ${_eigen_VERSIONS})
    endif()

endif()

#=======================
# Path search list.
#=======================
set(_eigen_SEARCH_PATHS ${EIGEN_LOCATION})

# Path search list from version search list.
#-----------------------
foreach(version ${_eigen_SEARCH_VERSIONS})
    set(_eigen_SEARCH_PATHS ${_eigen_SEARCH_PATHS}
        "${EIGEN_LOCATION}/${version}")
endforeach(version)

find_path(EIGEN_INCLUDE_DIRS Eigen/Core
    PATHS ${_eigen_SEARCH_PATHS}
    PATH_SUFFIXES
        include
    DOC "Eigen: include")

message(STATUS "Eigen: include = ${EIGEN_INCLUDE_DIRS}")

if (EIGEN_INCLUDE_DIRS)
    string(REGEX MATCH "[0-9].[0-9].[0-9]" EIGEN_VERSION "${EIGEN_INCLUDE_DIRS}")
endif()
message(STATUS "Eigen: version = ${EIGEN_VERSION}")

#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Eigen DEFAULT_MSG
    EIGEN_INCLUDE_DIRS EIGEN_VERSION)
