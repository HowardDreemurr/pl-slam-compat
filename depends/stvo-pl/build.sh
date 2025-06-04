echo "Building 3rdparty/line_descriptor ... "
cd 3rdparty/line_descriptor
mkdir -p build
cd build
cmake .. \
  -DCMAKE_PREFIX_PATH=../../../../installs \
  -DEIGEN3_INCLUDE_DIR=../../../../eigen
make -j$(nproc)
cd ../../../

echo "Building StVO-PL ... "
mkdir -p build
cd build
cmake .. \
  -DCMAKE_INSTALL_PREFIX=../../../installs \
  -DEIGEN3_INCLUDE_DIR=../eigen
make -j$(nproc)