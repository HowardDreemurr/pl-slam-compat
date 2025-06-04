mkdir -p build && cd build
mkdir -p ../../../installs
cmake .. -DCMAKE_INSTALL_PREFIX=../../../installs
make -j$(nproc)
sudo make install


