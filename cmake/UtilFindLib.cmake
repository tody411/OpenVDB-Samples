macro(UTIL_OUTPUT_HEADER target)
    message(STATUS "============================")
    message(STATUS "Find${target}")
    message(STATUS "============================")

    string(TOUPPER ${target} _up_target)
    message(STATUS "${target}: location = ${${_up_target}_LOCATION}")
endmacro(UTIL_OUTPUT_HEADER)

macro(UTIL_FIND_LOCATION target search_VERSIONS location_HINT)
    string(TOUPPER ${target} _up_target)
    set(_target_LOCATION ${_up_target}_LOCATION)
    set(_target_SEARCH_PATHS ${${_target_LOCATION}})

    # Path search list from version search list.
    foreach(version ${${search_VERSIONS}})
        set(_target_SEARCH_PATHS ${_target_SEARCH_PATHS} "${${_target_LOCATION}}/${version}")
    endforeach(version)

    message(STATUS "${target}: search paths = ${_target_SEARCH_PATHS}")

    find_path(_${target}_SEARCHED_LOCATION ${location_HINT}
    PATHS ${_target_SEARCH_PATHS}
    DOC "${target}: location")

    if(_${target}_SEARCHED_LOCATION)
        message(STATUS "${target}: searched location = ${_${target}_SEARCHED_LOCATION}")
        set(${_target_LOCATION} ${_${target}_SEARCHED_LOCATION})
    endif()

    message(STATUS "${target}: location = ${${_target_LOCATION}}")
endmacro(UTIL_FIND_LOCATION)

macro(UTIL_FIND_INCLUDE_DIRS target)
    string(TOUPPER ${target} _up_target)
    set(_target_LOCATION ${_up_target}_LOCATION)

    set(_target_INCLUDE_DIRS ${_up_target}_INCLUDE_DIRS)
    set(${_target_INCLUDE_DIRS} ${${_target_LOCATION}}/include)

    message(STATUS "${target}: include = ${${_target_INCLUDE_DIRS}}")
endmacro(UTIL_FIND_INCLUDE_DIRS)

macro(UTIL_FIND_LIBRARY_DIRS target)
    string(TOUPPER ${target} _up_target)
    set(_target_LOCATION ${_up_target}_LOCATION)

    set(_target_LIBRARY_DIRS ${_up_target}_LIBRARY_DIRS)
    set(${_target_LIBRARY_DIRS} ${${_target_LOCATION}}/lib)

    if(CMAKE_CL_64)
        set(${_target_LIBRARY_DIRS} ${${_target_LIBRARY_DIRS}}/x64)
    else()
        set({_target_LIBRARY_DIRS} ${${_target_LIBRARY_DIRS}}/x86)
    endif()

    message(STATUS "${target}: library = ${${_target_LIBRARY_DIRS}}")
endmacro(UTIL_FIND_LIBRARY_DIRS)

macro(UTIL_FIND_LIBRARIES target library_NAMES)
    string(TOUPPER ${target} _up_target)
    set(_target_LIBRARY_DIRS ${_up_target}_LIBRARY_DIRS)
    set(_target_LIBRARIES ${_up_target}_LIBRARIES)

    foreach(_target_lib ${library_NAMES})
        set(_target_LIBRARY ${_up_target}_${_target_lib}_LIBRARY)
        find_library(${_target_LIBRARY} ${_target_lib}
        PATHS ${${_target_LIBRARY_DIRS}}
        PATH_SUFFIXES lib
        DOC "${target}: ${_target_lib} library")

        if (${_target_LIBRARY})
            message(STATUS "${target}: ${_target_LIBRARY}: ${${_target_LIBRARY}}")
        endif()
        list(APPEND ${_target_LIBRARIES} ${${_target_LIBRARY}})
    endforeach()

    message(STATUS "${target}: ${_target_LIBRARIES}: ${${_target_LIBRARIES}}")

endmacro(UTIL_FIND_LIBRARIES)
