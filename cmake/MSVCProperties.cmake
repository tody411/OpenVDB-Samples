# - Visual Studio setting from CMake generator option.
#
# MSVC
#
# Inputs:
#  cmake -G <CMAKE_GENERATOR>    Specified generator from cmake command. e.g. "Visual Studio 11 Win64".
#
# Outputs:
#  MSVC_TOOL_VERSION             Visual Studio Version. Return 11 if "Visual Studio 11 Win64".
#  MSVC_ARCH                     Target architecture. 32: 32bit. 64: 64bit.

if (MSVC)
    message(STATUS "============================")
    message(STATUS "Visual Studio setting")
    message(STATUS "============================")
else()
    message(WARNING "Visual Studio: generator is not Visual Studio")
endif()

## Target architecture.
set(MSVC_ARCH 32)
if(CMAKE_CL_64)
    set(MSVC_ARCH 64)
endif()

if(MSVC90)
    set(MSVC_TOOL_VERSION 9)
elseif(MSVC10)
    set(MSVC_TOOL_VERSION 10)
elseif(MSVC11)
    set(MSVC_TOOL_VERSION 11)
elseif(MSVC12)
    set(MSVC_TOOL_VERSION 12)
elseif(MSVC14)
    set(MSVC_TOOL_VERSION 14)
endif()

message(STATUS "Visual Studio: Tool Version = ${MSVC_TOOL_VERSION}")
message(STATUS "Visual Studio: Architecture = ${MSVC_ARCH}")
message(STATUS "")