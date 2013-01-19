include_directories (${GGM_INCLUDE_DIRS}
                     ${GOBJECT_GMOCK_GENERATOR_INCLUDE_DIR})

add_library (gobject-gmock-generator SHARED
             ${CMAKE_CURRENT_SOURCE_DIR}/gobject-gmock-generator.cpp)

target_link_libraries (gobject-gmock-generator
                       ${GGM_LIBRARIES}
                       ${GMOCK_LIBRARY}
                       ${GMOCK_MAIN_LIBRARY}
                       ${GTEST_BOTH_LIBRARIES})
