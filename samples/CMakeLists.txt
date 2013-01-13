include (GObjectIntrospection)

# Include GLib and GObject
include_directories (${GGM_INCLUDE_DIRS}
                     $[GOBJECT_GMOCK_GENERATOR_INCLUDE_DIR})

set (_sources
     ${CMAKE_CURRENT_SOURCE_DIR}/sample-interface.c
     ${CMAKE_CURRENT_SOURCE_DIR}/sample-interface.h)

generate_gobject_introspection_data (GGMSample
                                     NAMESPACE GGM
                                     NAMESPACE_VERSION 0.1
                                     ADDITIONAL_PACKAGES glib-2.0
                                     SYMBOL_PREFIX ggm
                                     IDENTIFIER_PREFIX GGM
                                     SOURCES ${_sources}
                                     LIBRARY ggm_sample_interface)

# Only shared libraries are supported at the moment
add_library (ggm_sample_interface SHARED
             ${_sources})

target_link_libraries (ggm_sample_interface
                       ${GGM_LIBRARIES})

add_custom_target (ggm_introspection_data ALL DEPENDS
                   ${CMAKE_CURRENT_BINARY_DIR}/GGMSample.gir)
