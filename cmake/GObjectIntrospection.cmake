macro (_set_variables_for_list_markers _prefix _list_markers)

    # Set _current_variable to nothing, the error condition
    # is if we are trying to append to an empty variable
    # later
    set (_current_variable)

    # Set each of the _prefix_${VARIABLE}_set to FALSE
    # so that client code can tell whether or not those variables
    # were set
    foreach (_list_marker_variable ${_list_markers})
        set (${_prefix}_${_list_marker_variable})
        set (${_prefix}_${_list_marker_variable}_set FALSE)
    endforeach (_list_marker_variable)

    # Traverse each argument after _prefix. If we find an argument
    # whose name is the same as one of the markers in _list_marker_variables
    # set _current_variable to that marker. Otherwise, it should be treated
    # as a memeber of that list and appended to it.
    foreach (_variable ${ARGN})
        set (_variable_found FALSE)

        foreach (_find_list_marker_variable ${_list_markers})
            if ("${_find_list_marker_variable}" STREQUAL "${_variable}")
                set (_variable_found TRUE)
            endif ("${_find_list_marker_variable}" STREQUAL "${_variable}")
        endforeach (_find_list_marker_variable)

        if (_variable_found)
            set (_current_variable ${_variable})
            set (${_prefix}_${_current_variable}_SET TRUE)
        else (_variable_found)
            # _current_variable being nothing is an error condition
            set (_current_list ${_prefix}_${_current_variable})
            if ("${_current_list}" STREQUAL "${_prefix}")
                message (FATAL_ERROR "Attempted to append to empty list")
            endif ("${_current_list}" STREQUAL "${_prefix}")
            list (APPEND ${_prefix}_${_current_variable} ${_variable})
        endif (_variable_found)

    endforeach (_variable)

endmacro (_set_variables_for_list_markers)

function (generate_gobject_introspection_data gir_name)

    find_program (G_IR_SCANNER g-ir-scanner)

    if (NOT G_IR_SCANNER)

        message (SEND_ERROR "g-ir-scanner is required to generate "
                            "gobject introspection data. It is often called "
                            "gobject-introspection in most package managers.")

    endif (NOT G_IR_SCANNER)

    mark_as_advanced (FORCE G_IR_SCANNER)

    set (_list_marker_variables
         NAMESPACE
         NAMESPACE_VERSION
         ADDITIONAL_PACKAGES
         IDENTIFIER_PREFIX
         SYMBOL_PREFIX
         SOURCES
         LIBRARY
         ADDITIONAL_INCLUDES
         ADDITIONAL_LIBRARIES
         ADDITIONAL_LIBRARY_DIRS)

    _set_variables_for_list_markers (${gir_name} "${_list_marker_variables}" ${ARGN})

    if (NOT ${gir_name}_NAMESPACE_SET OR
        NOT ${gir_name}_NAMESPACE_VERSION_SET OR
        NOT ${gir_name}_IDENTIFIER_PREFIX_SET OR
        NOT ${gir_name}_SYMBOL_PREFIX_SET OR
        NOT ${gir_name}_SOURCES_SET OR
        NOT ${gir_name}_LIBRARY_SET)
        message (SEND_ERROR "A required variable was not set. Requires "
                            "variables are NAMESPACE NAMESPACE_VERSION "
                            "IDENTIFIER_PREFIX SYMBOL_PREFIX SOURCES LIBRARY")
    endif (NOT ${gir_name}_NAMESPACE_SET OR
           NOT ${gir_name}_NAMESPACE_VERSION_SET OR
           NOT ${gir_name}_IDENTIFIER_PREFIX_SET OR
           NOT ${gir_name}_SYMBOL_PREFIX_SET OR
           NOT ${gir_name}_SOURCES_SET OR
           NOT ${gir_name}_LIBRARY_SET)

    list (LENGTH ${gir_name}_NAMESPACE ${gir_name}_NAMESPACE_LENGTH)
    list (LENGTH ${gir_name}_NAMESPACE_VERSION ${gir_name}_NAMESPACE_VERSION_LENGTH)
    list (LENGTH ${gir_name}_IDENTIFIER_PREFIX ${gir_name}_IDENTIFIER_PREFIX_LENGTH)
    list (LENGTH ${gir_name}_SYMBOL_PREFIX ${gir_name}_SYMBOL_PREFIX_LENGTH)
    list (LENGTH ${gir_name}_LIBRARY ${gir_name}_LIBRARY_LENGTH)

    if (NOT ${${gir_name}_NAMESPACE_LENGTH} EQUAL 1 OR
        NOT ${${gir_name}_NAMESPACE_VERSION_LENGTH} EQUAL 1 OR
        NOT ${${gir_name}_IDENTIFIER_PREFIX_LENGTH} EQUAL 1 OR
        NOT ${${gir_name}_SYMBOL_PREFIX_LENGTH} EQUAL 1 OR
        NOT ${${gir_name}_LIBRARY_LENGTH} EQUAL 1)
        message (SEND_ERROR "The variables NAMESPACE NAMESPACE_VERSION "
                            "IDENTIFIER_PREFIX SYMBOL_PREFIX and LIBRARY "
                            "may only have one parameter")
    endif (NOT ${${gir_name}_NAMESPACE_LENGTH} EQUAL 1 OR
           NOT ${${gir_name}_NAMESPACE_VERSION_LENGTH} EQUAL 1 OR
           NOT ${${gir_name}_IDENTIFIER_PREFIX_LENGTH} EQUAL 1 OR
           NOT ${${gir_name}_SYMBOL_PREFIX_LENGTH} EQUAL 1 OR
           NOT ${${gir_name}_LIBRARY_LENGTH} EQUAL 1)

    list (APPEND ${gir_name}_LIBRARY_PATH "--library-path=${CMAKE_CURRENT_BINARY_DIR} ")
    foreach (_additional_library_path ${${gir_name}_ADDITIONAL_LIBRARY_DIRS})
        list (APPEND ${gir_name}_LIBRARY_PATH "--library-path=${additional_library_path}")
    endforeach (_additional_library_path)

    list (LENGTH ${gir_name}_ADDITIONAL_PACKAGES ${gir_name}_ADDITIONAL_PACKAGES_LENGTH)
    if (${${gir_name}_ADDITIONAL_PACKAGES_LENGTH} GREATER 0)
        foreach (_additional_package ${${gir_name}_ADDITIONAL_PACKAGES})
            list (APPEND ${gir_name}_PACKAGES "--pkg=${_additional_package}")
        endforeach (_additional_package)
    else (${${gir_name}_ADDITIONAL_PACKAGES_LENGTH} GREATER 0)
        set (${gir_name}_PACKAGES "")
    endif (${${gir_name}_ADDITIONAL_PACKAGES_LENGTH} GREATER 0)

    list (APPEND ${gir_name}_LIBRARIES "--library=${${gir_name}_LIBRARY}")
    foreach (_additional_library ${${gir_name}_ADDITIONAL_LIBRARIES})
        list (APPEND ${gir_name}_LIBRARIES "--library=${_additional_library}")
    endforeach (_additional_library)

    list (LENGTH ${gir_name}_ADDITIONAL_INCLUDES} ${gir_name}_ADDITIONAL_INCLUDES_LENGTH)

    if (${${gir_name}_ADDITIONAL_INCLUDES_LENGTH} GREATER 0)
        set (${gir_name}_ADDITIONAL_INCLUDES_PATH} -I${${gir_name}_ADDITIONAL_INCLUDES})
    else (${${gir_name}_ADDITIONAL_INCLUDES_LENGTH} GREATER 0)
        set (${gir_name}_ADDITIONAL_INCLUDES} "")
    endif (${${gir_name}_ADDITIONAL_INCLUDES_LENGTH} GREATER 0)

    add_custom_command (OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${gir_name}.gir
                        COMMAND ${G_IR_SCANNER}
                        ARGS --no-libtool
                        --quiet
                        --warn-all
                        --warn-error
                        --namespace=${${gir_name}_NAMESPACE}
                        --nsversion=${${gir_name}_NAMESPACE_VERSION}
                        --identifier-prefix=${${gir_name}_IDENTIFIER_PREFIX}
                        --symbol-prefix=${${gir_name}_SYMBOL_PREFIX}
                        ${${gir_name}_PACKAGES}
                        ${${gir_name}_LIBRARY_PATH}
                        ${${gir_name}_LIBRARIES}
                        ${${gir_name}_ADDITIONAL_INCLUDES}
                        ${${gir_name}_SOURCES}
                        --output=${CMAKE_CURRENT_BINARY_DIR}/${gir_name}.gir
                        VERBATIM
                        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                        COMMENT "Create GObjectIntrospection ${gir_name}.gir"
                        DEPENDS ${${gir_name}_SOURCES} ${${gir_name}_LIBRARY})

endfunction (generate_gobject_introspection_data)

function (generate_mocks_from_gobject_introspection_data
          _gir_file _mock_dir _mock_name)

    find_program (XSLTPROC xsltproc)

    if (NOT XSLTPROC)

        message (SEND_ERROR "xsltproc is required to generate "
                            "google mocks. It is often called "
                            "xsltproc in most package managers. ")

    endif (NOT XSLTPROC)

endfunction (generate_mocks_from_gobject_introspection_data)
