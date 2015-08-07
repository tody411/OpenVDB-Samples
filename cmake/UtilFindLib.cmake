function(UTIL_OUTPUT_HEADER target)
    message(STATUS "============================")
    message(STATUS "Find${target}")
    message(STATUS "============================")

    string(TOUPPER ${target} _up_target)
    message(STATUS "${target}: location = ${${_up_target}_LOCATION}")
endfunction(UTIL_OUTPUT_HEADER)

function(UTIL_FIND_LOCATION target search_VERSIONS location_HINT location_Var)
    string(TOUPPER ${target} _up_target)
    set(_target_LOCATION ${_up_target}_LOCATION)
    set(_search_PATHS ${${_target_LOCATION}})

    # Path search list from version search list.
    foreach(version ${${search_VERSIONS}})
        set(_search_PATHS ${_search_PATHS} "${${_target_LOCATION}}/${version}")
    endforeach(version)

    message(STATUS "${target}: search paths = ${_search_PATHS}")

    message(STATUS "${target}: location_HINT = ${location_HINT}")

    find_path(_${target}_SEARCHED_LOCATION ${location_HINT}
        PATHS ${_search_PATHS}
        DOC "${target}: location")

    if(_${target}_SEARCHED_LOCATION)
        message(STATUS "${target}: searched location = ${_${target}_SEARCHED_LOCATION}")

        set(${location_Var} ${_${target}_SEARCHED_LOCATION} PARENT_SCOPE)
    endif()

    message(STATUS "${target}: location = ${_${target}_SEARCHED_LOCATION}")
endfunction(UTIL_FIND_LOCATION)

function(UTIL_FIND_INCLUDE_DIRS target include_Dirs_Var)
    string(TOUPPER ${target} _up_target)
    set(_target_LOCATION ${_up_target}_LOCATION)

    set(include_Dir ${${_target_LOCATION}}/include)

    set(include_Dirs ${${include_Dirs_Var}})
    list(APPEND include_Dirs ${include_Dir})

    set(${include_Dirs_Var} ${include_Dirs} PARENT_SCOPE)

    message(STATUS "${target}: include = ${include_Dirs}")
endfunction(UTIL_FIND_INCLUDE_DIRS)

function(UTIL_FIND_LIBRARY_DIRS target library_Dirs_Var)
    string(TOUPPER ${target} _up_target)
    set(_target_LOCATION ${_up_target}_LOCATION)

    set(library_Dir ${${_target_LOCATION}}/lib)

    set(library_Dirs ${${library_Dirs_Var}})
    list(APPEND library_Dirs ${library_Dir})

    if(CMAKE_CL_64)
        set(library_Dir ${library_Dir}/x64)
    else()
        set(library_Dir ${library_Dir}/x86)
    endif()


    list(APPEND library_Dirs ${library_Dir})
    set(${library_Dirs_Var} ${library_Dirs} PARENT_SCOPE)
    message(STATUS "${target}: library = ${library_Dirs}")
endfunction(UTIL_FIND_LIBRARY_DIRS)

function(UTIL_FIND_LIBRARIES target library_NAMES libraries_Var)
    string(TOUPPER ${target} _up_target)
    set(_target_LIBRARY_DIRS ${_up_target}_LIBRARY_DIRS)
    set(_target_LIBRARIES ${_up_target}_LIBRARIES)

    message(STATUS "${target}: library = ${${_target_LIBRARY_DIRS}}")

    set(_libraries ${${libraries_Var}})

    foreach(_target_lib ${${library_NAMES}})
        message(STATUS "${target}: target_lib = ${_target_lib}")
        set(_target_LIBRARY ${_up_target}_${_target_lib}_LIBRARY)

        find_library(_${target}_SEARCHED_LIBRARY ${_target_lib}
        PATHS ${${_target_LIBRARY_DIRS}}
        PATH_SUFFIXES lib
        DOC "${target}: ${_target_lib} library")

        if (${_${target}_SEARCHED_LIBRARY})
            message(STATUS "${target}: _searched_LIBRARY: ${_${target}_SEARCHED_LIBRARY}")
        endif()
        list(APPEND _libraries ${_${target}_SEARCHED_LIBRARY})
    endforeach()

    set(${libraries_Var} ${_libraries} PARENT_SCOPE)
    message(STATUS "${target}: ${_target_LIBRARIES}: ${_libraries}")

endfunction(UTIL_FIND_LIBRARIES)

function(UTIL_FIND_DLLS target library_NAMES libraries_Var)
    string(TOUPPER ${target} _up_target)
    set(_target_LIBRARY_DIRS ${_up_target}_LIBRARY_DIRS)
    set(_target_LIBRARIES ${_up_target}_LIBRARIES)

    message(STATUS "${target}: library = ${${_target_LIBRARY_DIRS}}")

    set(_libraries ${${libraries_Var}})

    foreach(_target_lib ${${library_NAMES}})
        message(STATUS "${target}: target_lib = ${_target_lib}")
        set(_target_DLL ${_up_target}_${_target_lib}_DLL)

        set(${_target_DLL} "${${_target_LIBRARY_DIRS}}/${_target_lib}.dll")

        list(APPEND _libraries "${${_target_DLL}}")
    endforeach()

    set(${libraries_Var} ${_libraries} PARENT_SCOPE)
    message(STATUS "${target}: ${_target_DLL}: ${_libraries}")

endfunction(UTIL_FIND_DLLS)
