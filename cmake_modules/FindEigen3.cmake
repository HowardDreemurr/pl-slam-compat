# FindEigen3.cmake
# Locate the Eigen3 library
# Defines: EIGEN3_FOUND, EIGEN3_INCLUDE_DIR

find_path(EIGEN3_INCLUDE_DIR
    NAMES Eigen/Core
    PATHS
        ${EIGEN3_ROOT_DIR}
        $ENV{EIGEN3_ROOT_DIR}
        ${CMAKE_PREFIX_PATH}/include/mrpt/base/include
        ${PROJECT_SOURCE_DIR}/../installs/include/mrpt/base/include
        ~/pl-slam/installs/include/mrpt/base/include
        /usr/include/eigen3
        /usr/local/include/eigen3
        /opt/local/include/eigen3
        /opt/local/include
        /usr/include
        /usr/local/include
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Eigen3 REQUIRED_VARS EIGEN3_INCLUDE_DIR)

if(EIGEN3_FOUND)
    set(Eigen3_INCLUDE_DIRS ${EIGEN3_INCLUDE_DIR})
    set(Eigen3_INCLUDE_DIR ${EIGEN3_INCLUDE_DIR}) # Compatibility
endif()

mark_as_advanced(EIGEN3_INCLUDE_DIR)

