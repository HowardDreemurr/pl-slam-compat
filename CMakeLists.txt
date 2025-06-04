project( PL-SLAM )

add_definitions(-DUF_long=SuiteSparse_long)

add_compile_options(-Wno-ignored-attributes)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake_modules")

cmake_minimum_required(VERSION 2.7)
find_package(OpenCV 3 REQUIRED)
find_package(Boost    REQUIRED COMPONENTS thread system filesystem)
find_package(Eigen3   REQUIRED)
find_package(G2O      REQUIRED)

if(COMMAND cmake_policy)
  	cmake_policy(SET CMP0003 NEW)	
endif(COMMAND cmake_policy)
link_directories(${OpenCV_LIBS_DIR})
include_directories(${OpenCV2_INCLUDE_DIRS})

set(DEFAULT_HAS_MRPT ON)
set(HAS_MRPT ${DEFAULT_HAS_MRPT} CACHE BOOL "Build the PointGrey Bumblebee2 SVO application that employs the MRPT library")

SET(BUILD_SHARED_LIBS ON)
SET(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -O3 -mtune=native -march=native")

# MRPT library (optional, only with representation purposes)
if(HAS_MRPT)
FIND_PACKAGE(MRPT REQUIRED base opengl gui hwdrivers)
set(MRPT_DONT_USE_DBG_LIBS 1) #use release libraries for linking even if "Debug" CMake build
add_definitions(-DHAS_MRPT)
endif(HAS_MRPT)

# YAML library
find_library(YAML_CPP_LIBRARIES yaml-cpp)
if(NOT YAML_CPP_LIBRARIES)
  # If yaml-cpp not found in the system, try finding it as a user CMake-generated project
  find_package(yaml-cpp REQUIRED)
  include_directories(${YAML_CPP_INCLUDE_DIRS})
endif(NOT YAML_CPP_LIBRARIES)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/build)
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

SET(G2O_LIBS
    g2o_core
    g2o_types_slam3d
    g2o_types_slam2d
    cholmod
)

# Include dirs
include_directories(
  include
  ${Eigen3_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
  ${YAML_CPP_INCLUDE_DIRS}
  ${PROJECT_SOURCE_DIR}/3rdparty/DBoW2/DBoW2/
  ${PROJECT_SOURCE_DIR}/3rdparty/line_descriptor/include/
  ${G2O_INCLUDE_DIR}
  /usr/include/suitesparse # for cholmod
)

# Set link libraries
list(APPEND LINK_LIBS 
  ${OpenCV_LIBS}
  ${Boost_LIBRARIES}
  ${YAML_CPP_LIBRARIES}
  ${G2O_LIBS}
  ${PROJECT_SOURCE_DIR}/3rdparty/DBoW2/lib/libDBoW2.so
  ${PROJECT_SOURCE_DIR}/3rdparty/line_descriptor/lib/liblinedesc.so
)

# Set source files 
if(HAS_MRPT)
list(APPEND SOURCEFILES
  src/config.cpp
  src/auxiliar.cpp
  src/pinholeStereoCamera.cpp
  src/stereoFeatures.cpp
  src/stereoFrame.cpp
  src/stereoFrameHandler.cpp
  src/mapHandler.cpp
  src/mapFeatures.cpp
  src/keyFrame.cpp
  src/voScene.cpp
  src/slamScene.cpp
)
else()
list(APPEND SOURCEFILES
  src/config.cpp
  src/auxiliar.cpp
  src/pinholeStereoCamera.cpp
  src/stereoFeatures.cpp
  src/stereoFrame.cpp
  src/stereoFrameHandler.cpp
  src/mapHandler.cpp
  src/mapFeatures.cpp
  src/keyFrame.cpp
)
endif()

# List all files (headers) contained by StVO-PL library
file(GLOB_RECURSE all_include_files RELATIVE "${CMAKE_SOURCE_DIR}" *.h *.hpp)

# Visualize the files of this directory in IDE creating an custom empty target
add_custom_target( plslam_includes DEPENDS ${all_include_files} SOURCES ${all_include_files} )

# Create StVO-PL library
add_library(plslam SHARED ${SOURCEFILES})

if(HAS_MRPT)
target_link_libraries(plslam ${LINK_LIBS} ${MRPT_LIBS}  )
else()
target_link_libraries(plslam ${LINK_LIBS})
endif()

# Applications [TODO: ADD VO APPLICATIONS]
if(HAS_MRPT)
add_executable       ( plslam_dataset app/plslam_dataset.cpp )
target_link_libraries( plslam_dataset plslam )
add_executable       ( plstvo_dataset app/plstvo_dataset.cpp )
target_link_libraries( plstvo_dataset plslam )
endif(HAS_MRPT)







