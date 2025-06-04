#!/bin/bash

echo "[PL-SLAM] Updating & Installing Dependencies..."

sudo apt update && sudo apt install -y \
  build-essential cmake git pkg-config \
  libboost-all-dev libsuitesparse-dev \
  libyaml-cpp-dev libglew-dev libgl1-mesa-dev libegl1-mesa-dev \
  libxkbcommon-dev libglfw3-dev libpython3-dev libpython2.7-dev \
  libjpeg-dev libpng-dev libtiff-dev libavcodec-dev \
  libavformat-dev libswscale-dev libgtk2.0-dev \
  qt5-default libqglviewer-dev-qt5 python2 libassimp-dev \
  libwxgtk3.0-gtk3-dev freeglut3-dev python-numpy

cd depends

echo "Building Dependencies: Eigen 3.2.5..."
cd eigen
bash build.sh
cd ..

echo "Building Dependencies: OpenCV 3.4.1..."
cd opencv
bash build.sh
cd ..

echo "Building Dependencies: G2O (20170730_git)..."
cd g2o
bash build.sh
cd ..

echo "Building Dependencies: MRPT 1.5.0..."
cd mrpt
bash build.sh
cd ..

echo "Building Dependencies: StVO-PL (e8ddf54)..."
cd stvo-pl
bash build.sh
cd ..

echo "Building PL-SLAM (Initial Commit)..."
bash build.sh

echo "[PL-SLAM] INSTALL SUCCESSFUL"
echo
echo "USAGE:"
echo "  cd build"
echo "  ./plslam_dataset <relative_path_from_DATASETS_DIR>"
echo "  ./plstvo_dataset <relative_path_from_DATASETS_DIR>"
echo
echo "ENVIRONMENT SETUP:"
echo "  export DATASETS_DIR=<your_dataset_root_path>"
echo "  export LD_LIBRARY_PATH=\$HOME/pl-slam/installs/lib:\$LD_LIBRARY_PATH"
echo
echo "OPTIONAL:"
echo "  Disable points:  export PLSAM_NO_POINTS=1"
echo "  Disable lines:   export PLSAM_NO_LINES=1"


