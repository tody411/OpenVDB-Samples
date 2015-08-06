# - Find Maya package for Windows.
#
# Inputs:
#  MAYA_LOCATION          If defined, it will be searched first for Maya location.
#
# Outputs:
#  MAYA_FOUND             Defined if a Maya is found.
#  MAYA_VERSION           Version of detected Maya (e.g. 2015).
#
#  MAYA_INCLUDE_DIRS      Path to Maya's include directories.
#
#  MAYA_LIBRARY_DIRS      Path to Maya's library directories.
#  MAYA_LIBRARIES         List of detected Maya libraries.
#  MAYA_<Lib>_FOUND       Defined if <Lib> is found.
#  MAYA_<Lib>_LIBRARY     <Lib> Path.
#
#  MAYA_EXE               Maya's executable path.
#  MAYA_PLUGIN_SUFFIX     Maya plug-in file extension.
#
#  MAYA_MSVC_VERSION      Maya Visual Studio version.
#
#  MAYA_USER_DIR          Maya user directory.
#
# Macros:
#  Maya_set_target_properties   Set target properties for the target project name.
#  Maya_set_compile_properties  Set compile properties for the target project name.
#  Maya_set_output_properties   Set output properties for the target project name.

message(STATUS "============================")
message(STATUS "FindMaya")
message(STATUS "============================")

#=======================
# Predefined variables
#=======================
set(MAYA_PLUGIN_SUFFIX ".mll")

#=======================
# Version search list.
#=======================
set(_maya_VERSIONS)
foreach(version RANGE 2016 2008 -1)
    list(APPEND _maya_VERSIONS "${version}")
endforeach()

set(_maya_SEARCH_VERSIONS)

if(Maya_FIND_VERSION_EXACT)
    # for e.g. find_package(Maya 2015 EXACT)
    list(APPEND _maya_SEARCH_VERSIONS "${Maya_FIND_VERSION}")

else()
    if(Maya_FIND_VERSION)
        # for e.g. find_package(Maya 2015)
        foreach(version ${_maya_VERSIONS})
            if(NOT "${version}" VERSION_LESS "${Maya_FIND_VERSION}")
                list(APPEND _maya_SEARCH_VERSIONS "${version}")
            endif()
        endforeach()

    else()
        # find_package(Maya REQUIRED)
        set(_maya_SEARCH_VERSIONS ${_maya_VERSIONS})
    endif()

endif()

#=======================
# Path search list.
#=======================
set(_maya_SEARCH_PATHS)

# Path search list from version search list.
#-----------------------
foreach(version ${_maya_SEARCH_VERSIONS})
    set(_maya_SEARCH_PATHS ${_maya_SEARCH_PATHS}
        "$ENV{PROGRAMFILES}/Autodesk/Maya${version}-x64"
        "$ENV{PROGRAMFILES}/Autodesk/Maya${version}"
        "C:/Program Files/Autodesk/Maya${version}-x64"
        "C:/Program Files/Autodesk/Maya${version}"
        "C:/Program Files (x86)/Autodesk/Maya${version}")
endforeach(version)

# Maya EXE path from the MAYA_LOCATION and _maya_SEARCH_PATHS.
#-----------------------
find_program(MAYA_EXE maya
    PATHS $ENV{MAYA_LOCATION} ${_maya_SEARCH_PATHS}
    PATH_SUFFIXES bin
    NO_SYSTEM_ENVIRONMENT_PATH
    DOC "Maya EXE")

if(MAYA_EXE)
    # MAYA_LOCATION, MAYA_VERSION from MAYA_EXE.
    string(REGEX REPLACE "/bin/maya.*" "" MAYA_LOCATION "${MAYA_EXE}")
    string(REGEX MATCH "20[0-9][0-9]" MAYA_VERSION "${MAYA_LOCATION}")

else()
    # Failed to find Maya
    set(MAYA_LOCATION NOTFOUND)
    if(Maya_FIND_VERSION)
        message(FATAL_ERROR "Maya: failed to find version >= ${Maya_FIND_VERSION}")

    else()
        message(FATAL_ERROR "Maya: failed to find any versions")
    endif()
endif()

message(STATUS "Maya: location = ${MAYA_LOCATION}")

#=======================
# Visual Studio versions
#=======================
if(${MAYA_VERSION} STREQUAL "2011")
    set(MAYA_MSVC_VERSION "9")
elseif(${MAYA_VERSION} STREQUAL "2012")
    set(MAYA_MSVC_VERSION  "9")
elseif(${MAYA_VERSION} STREQUAL "2013")
    set(MAYA_MSVC_VERSION  "10")
elseif(${MAYA_VERSION} STREQUAL "2014")
    set(MAYA_MSVC_VERSION  "10")
elseif(${MAYA_VERSION} STREQUAL "2015")
    set(MAYA_MSVC_VERSION  "11")
elseif(${MAYA_VERSION} STREQUAL "2016")
    set(MAYA_MSVC_VERSION  "11")
endif()

message(STATUS "Maya: Visual Studio Tool Version = ${MAYA_MSVC_VERSION}")

#=======================
# Include
#=======================
find_path(MAYA_INCLUDE_DIRS maya/MFn.h
    HINTS ${MAYA_LOCATION}
    PATH_SUFFIXES
        include
    DOC "Maya: include")

message(STATUS "Maya: include = ${MAYA_INCLUDE_DIRS}")

#=======================
# Library
#=======================
find_path(MAYA_LIBRARY_DIRS OpenMaya.lib
    HINTS ${MAYA_LOCATION}
    PATH_SUFFIXES
        lib
    DOC "Maya: library")

message(STATUS "Maya: library = ${MAYA_LIBRARY_DIRS}")

foreach(_maya_lib
    OpenMaya
    OpenMayaAnim
    OpenMayaFX
    OpenMayaRender
    OpenMayaUI
    Image
    Foundation
    IMFbase
    tbb)

    find_library(MAYA_${_maya_lib}_LIBRARY ${_maya_lib}
        HINTS ${MAYA_LOCATION}
        PATHS ${_maya_SEARCH_PATHS}
        PATH_SUFFIXES lib
        DOC "Maya: ${MAYA_LIB} library")
    list(APPEND MAYA_LIBRARIES ${MAYA_${_maya_lib}_LIBRARY})
endforeach()

# message(STATUS "Maya: libraries = ${MAYA_LIBRARIES}")

#=======================
# User directory
#=======================
find_path(MAYA_USER_DIR
    NAMES ${MAYA_VERSION}-x64 ${MAYA_VERSION}
    PATHS
        $ENV{USERPROFILE}/Documents/maya
    DOC "Maya: user directory"
    NO_SYSTEM_ENVIRONMENT_PATH)

message(STATUS "Maya: user directory = ${MAYA_USER_DIR}")
message(STATUS "")


#=======================
# Find package
#=======================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Maya DEFAULT_MSG
    MAYA_LIBRARIES MAYA_EXE MAYA_INCLUDE_DIRS
    MAYA_LIBRARY_DIRS MAYA_VERSION MAYA_PLUGIN_SUFFIX
    MAYA_USER_DIR)

#=======================
# Macros
#=======================
# Set compile properties for the target project name.
#-----------------------
macro(Maya_set_compile_properties target)
    set(MAYA_COMPILE_DEFINITIONS REQUIRE_IOSTREAM _BOOL _AFXDLL _MBCS NT_PLUGIN)
    set(MAYA_COMPILE_FLAGS "/MD")
    set(MAYA_LINK_FLAGS "/export:initializePlugin /export:uninitializePlugin")

    set_target_properties( ${target} PROPERTIES
        COMPILE_DEFINITIONS "${MAYA_COMPILE_DEFINITIONS}"
        COMPILE_FLAGS "${MAYA_COMPILE_FLAGS}"
        LINK_FLAGS "${MAYA_LINK_FLAGS}"
        PREFIX ""
        SUFFIX ${MAYA_PLUGIN_SUFFIX}
    )
endmacro(Maya_set_compile_properties)

# Set output properties for the target project name.
#-----------------------
macro(Maya_set_output_properties target)
    set(_plugin_NAME ${target}${MAYA_VERSION})
    set(_plugin_DIR ${PROJECT_SOURCE_DIR}/plugins)
    set_target_properties( ${target} PROPERTIES
        OUTPUT_NAME ${_plugin_NAME}
        RUNTIME_OUTPUT_DIRECTORY ${_plugin_DIR}
        RUNTIME_OUTPUT_DIRECTORY_DEBUG ${_plugin_DIR}
        RUNTIME_OUTPUT_DIRECTORY_RELEASE ${_plugin_DIR}
        CLEAN_DIRECT_OUTPUT 1
    )

    message(STATUS "============================")
    message(STATUS "Output setting")
    message(STATUS "============================")
    message(STATUS "Output: project name = ${target}")
    message(STATUS "Output: plug-in name = ${_plugin_NAME}${MAYA_PLUGIN_SUFFIX}")
    message(STATUS "Output: output directory = ${_plugin_DIR}")
    message(STATUS "")
endmacro(Maya_set_output_properties)

# Set target properties for the target project name.
#-----------------------
macro(Maya_set_target_properties target)
    Maya_set_output_properties(${target})
    Maya_set_compile_properties(${target})
endmacro(Maya_set_target_properties)