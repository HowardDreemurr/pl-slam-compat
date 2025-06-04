mkdir -p build && cd build
mkdir -p ../../../installs
cmake -D CMAKE_BUILD_TYPE=Release \
      -DEIGEN3_INCLUDE_DIR=../eigen \
      -D CMAKE_INSTALL_PREFIX=../../../installs \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF ..
make -j$(nproc)
sudo make install

