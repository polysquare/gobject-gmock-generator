cmake_minimum_required (VERSION 2.8)
project (gobject_gmock_generator)

include (FindPkgConfig)

set (GGM_REQUIRED
     glib-2.0
     gobject-2.0)

# Default build type is RelWithDbgInfo
set (CMAKE_BUILD_TYPE RelWithDbgInfo)

# -fPIC, -Wall and -Werror are mandatory
set (COMPILER_FLAGS "-fPIC -Wall -Werror")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMPILER_FLAGS}")
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COMPILER_FLAGS}")

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
                          ${CMAKE_CURRENT_BINARY_DIR}/src/gtest)

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
    message (SEND_ERROR "Google Test and Google Mock are required to "
                        "build gobject-gmock-generator. They are often "
                        "called libgtest-dev and google-mock in most "
                        "package managers.")
endif (NOT GTEST_FOUND OR
       NOT GMOCK_LIBRARY OR
       NOT GMOCK_MAIN_LIBRARY)

pkg_check_modules (GGM REQUIRED ${GGM_REQUIRED})

if (GGM_FOUND)

    set (CMAKE_MODULE_PATH
         ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

    set (GOBJECT_GMOCK_GENERATOR_INCLUDE_DIR
         ${CMAKE_CURRENT_SOURCE_DIR}/include)

    add_subdirectory (src)
    add_subdirectory (samples)

endif (GGM_FOUND)
