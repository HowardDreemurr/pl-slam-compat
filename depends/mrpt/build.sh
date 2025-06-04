mkdir -p build && cd build
mkdir -p ../../../installs
cmake ..  -DCMAKE_INSTALL_PREFIX=../../../installs \
	-DEIGEN3_INCLUDE_DIR=../../../installs/include/eigen3 \
  	-DEigen3_INCLUDE_DIR=../../../installs/include/eigen3 \
	-DUSE_SYSTEM_EIGEN3=ON \
  	-DMRPT_USE_SYSTEM_EIGEN3=ON \
  	-DMRPT_DISABLE_EMBEDDED_EIGEN=ON \
  	-DMRPT_ENABLE_PRECOMPILED_HDRS=OFF  \
  	-DBUILD_TESTING=OFF \
	-DUSE_EXTERNAL_OCTOMAP=OFF
make -j$(nproc)
sudo make install
