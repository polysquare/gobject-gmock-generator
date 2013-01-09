# Include GLib and GObject
include_directories (${GGM_INCLUDE_DIRS})

# Only shared libraries are supported at the moment
add_library (ggm_sample_interface SHARED
             ${CMAKE_CURRENT_SOURCE_DIR}/sample-interface.c)

target_link_libraries (ggm_sample_interface
                       ${GGM_LIBRARIES})
