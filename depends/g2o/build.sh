mkdir -p build && cd build
mkdir -p ../../../installs
cmake .. -DCMAKE_INSTALL_PREFIX=../../../installs\
	 -DEIGEN3_INCLUDE_DIR=../eigen \
         -DBUILD_SHARED_LIBS=ON \
	 -DBUILD_LIST=core,imgproc,calib3d,highgui,features2d \
	 -DBUILD_opencv_xfeatures2d=OFF \
         -DG2O_USE_CMAKE_CONFIG=ON \
         -DG2O_BUILD_EXAMPLES=OFF \
         -DG2O_BUILD_APPS=OFF \
         -DG2O_SOLVER_CHOLMOD=ON
make -j$(nproc)
sudo make install


