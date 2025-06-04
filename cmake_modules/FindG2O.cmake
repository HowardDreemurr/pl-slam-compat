# FindG2O.cmake

find_path(G2O_INCLUDE_DIR
    NAMES g2o/core/base_vertex.h
    PATHS
        ${CMAKE_PREFIX_PATH}/include
        ${CMAKE_PREFIX_PATH}
        $ENV{G2O_DIR}/include
        ${PROJECT_SOURCE_DIR}/../installs/include
        ~/pl-slam/installs/g2o/include
)

find_library(G2O_CORE_LIBRARY
    NAMES g2o_core
    PATHS
        ${CMAKE_PREFIX_PATH}/lib
        $ENV{G2O_DIR}/lib
        ${PROJECT_SOURCE_DIR}/../installs/lib
        ~/pl-slam/installs/g2o/lib
)

find_library(G2O_STUFF_LIBRARY
    NAMES g2o_stuff
    PATHS
        ${CMAKE_PREFIX_PATH}/lib
        $ENV{G2O_DIR}/lib
        ${PROJECT_SOURCE_DIR}/../installs/lib
        ~/pl-slam/installs/g2o/lib
)

set(G2O_INCLUDE_DIRS ${G2O_INCLUDE_DIR})
set(G2O_LIBRARIES ${G2O_CORE_LIBRARY} ${G2O_STUFF_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(G2O DEFAULT_MSG G2O_INCLUDE_DIR G2O_CORE_LIBRARY G2O_STUFF_LIBRARY)

