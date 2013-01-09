cmake_minimum_required (VERSION 2.8)
project (gobject_gmock_generator)

include (FindPkgConfig)

set (GGM_REQUIRED
     glib-2.0)

find_package (GTest QUIET)

if (NOT GTEST_FOUND)

    # Find the the Google Test include directory
    # by searching the system-wide include directory
    # paths
    find_path (GTEST_INCLUDE_DIR
               gtest/gtest.h)

    if (GTEST_INCLUDE_DIR)
        set (GTEST_INCLUDE_BASE "include/")
        string (LENGTH ${GTEST_INCLUDE_BASE} GTEST_INCLUDE_BASE_LENGTH)
        string (LENGTH ${GTEST_INCLUDE_DIR} GTEST_INCLUDE_DIR_LENGTH)

        message (${GTEST_INCLUDE_DIR_LENGTH} ${GTEST_INCLUDE_BASE_LENGTH})
        math (EXPR
              GTEST_INCLUDE_PREFIX_LENGTH
              "${GTEST_INCLUDE_DIR_LENGTH} - ${GTEST_INCLUDE_BASE_LENGTH}")
        string (SUBSTRING
                ${GTEST_INCLUDE_DIR}
                0
                ${GTEST_INCLUDE_PREFIX_LENGTH}
                GTEST_INCLUDE_PREFIX)

        set (GTEST_SRC_DIR ${GTEST_INCLUDE_PREFIX}/src/gtest)

        add_subdirectory (${GTEST_SRC_DIR}
                          ${CMAKE_CURRENT_BINARY_DIR}/src)

        set (GTEST_BOTH_LIBRARIES
             gtest gtest_main)

        set (GTEST_FOUND TRUE)
    endif (GTEST_INCLUDE_DIR)

endif (NOT GTEST_FOUND)

# Find the Google Mock libraries in the systemwide library directories
find_library (GMOCK_LIBRARY gmock)
find_library (GMOCK_MAIN_LIBRARY gmock_main)

if (NOT GTEST_FOUND OR
    NOT GMOCK_LIBRARY OR
    NOT GMOCK_MAIN_LIBRARY)
    message (FATAL_ERROR "Google Test and Google Mock are required to "
                         "build gobject-gmock-generator. They are often "
                         "called libgtest-dev and google-mock in most "
                         "package managers.")
endif (NOT GTEST_FOUND OR
       NOT GMOCK_LIBRARY OR
       NOT GMOCK_MAIN_LIBRARY)

find_program (G_IR_SCANNER g-ir-scanner)

if (NOT G_IR_SCANNER)

    message (FATAL_ERROR "g-ir-scanner is required to build "
                         "gobject-gmock-generator. It is often called "
                         "gobject-introspection in most package managers.")

endif (NOT G_IR_SCANNER)

mark_as_advanced (FORCE G_IR_SCANNER)

pkg_check_modules (GGM REQUIRED ${GGM_REQUIRED})

if (GGM_FOUND)

    add_subdirectory (samples)

endif (GGM_FOUND)

    
