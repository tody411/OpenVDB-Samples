cmake_minimum_required(VERSION 3.0.0)

#=======================
# CMake module path
#=======================
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/../cmake")

#=======================
# Project setting
#=======================
project(vdb_conv)
file(GLOB _project_SOURCE ${PROJECT_SOURCE_DIR}/src/*.h ${PROJECT_SOURCE_DIR}/src/*.cpp ${PROJECT_SOURCE_DIR}/src/io/*.cc)

#=======================
# Setup External Libraries
#=======================
include(SetupExtLibs)

#=======================
# Visual Studio setting
#=======================
include(MSVCProperties)

#=======================
# Find OpenVDB
#=======================
find_package(OpenVDB REQUIRED)

#=======================
# Find boost
#=======================
find_package(boost REQUIRED)

#=======================
# Find OpenCV
#=======================
find_package(OpenCV REQUIRED)

#=======================
# Find Qt
#=======================
set(CMAKE_AUTOMOC ON)
set (CMAKE_PREFIX_PATH "C:/Program Files (x86)/Windows Kits/8.0/Lib/win8/um/x64")
find_package(Qt5Core)

#=======================
# Include setting
#=======================
include_directories(
    ${BOOST_INCLUDE_DIRS}
    ${OPENVDB_INCLUDE_DIRS}
    ${OPENCV_INCLUDE_DIRS}
    ${PROJECT_SOURCE_DIR}/src)

#=======================
# Plug-in entry point
#=======================
add_executable( ${PROJECT_NAME} ${_project_SOURCE} )

#=======================
# Link setting
#=======================
qt5_use_modules(${PROJECT_NAME} Core)
target_link_libraries( ${PROJECT_NAME} ${OPENVDB_LIBRARIES} ${BOOST_LIBRARIES} ${OPENCV_LIBRARIES} ${QT_LIBRARIES})

#=======================
# Output settings.
#=======================
set(_bin_DIR ${PROJECT_SOURCE_DIR}/bin)
set_target_properties( ${PROJECT_NAME} PROPERTIES
    OUTPUT_NAME ${PROJECT_NAME}
    RUNTIME_OUTPUT_DIRECTORY ${_bin_DIR}
    RUNTIME_OUTPUT_DIRECTORY_DEBUG ${_bin_DIR}
    RUNTIME_OUTPUT_DIRECTORY_RELEASE ${_bin_DIR}
    CLEAN_DIRECT_OUTPUT 1
)