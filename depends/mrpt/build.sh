mkdir -p build && cd build
mkdir -p ../../../installs
cmake ..  -DCMAKE_INSTALL_PREFIX=../../../installs\
	-DCMAKE_BUILD_TYPE=Release \
	-DUSE_EXTERNAL_OCTOMAP=OFF\
make -j$(nproc)
sudo make install
