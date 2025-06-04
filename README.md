# PL-SLAM-Compat

A dependencies-included, ready-to-run version of the original [PL-SLAM](https://github.com/rubengooj/pl-slam) at commit `6b20b0c`.

This repository integrates all core dependencies (Eigen 3.2.5, OpenCV 3.4.1, G2O, MRPT, and StVO-PL) with pre-configured build scripts, making PL-SLAM easy to compile and run on modern Ubuntu systems.

---

## 📦 Features

- ✅ Dependencies bugs fixed
- ✅ All core dependencies are bundled and built automatically  
- ✅ Single command build via `build_master.sh`  
- ✅ **No need to modify code to switch between P-SLAM / L-SLAM / PL-SLAM**  

---

## 🚀 Quick Start

### 0. Just run build_master.sh

Make sure you're on Ubuntu 20.04 LTS (Other version may have env problems, tested 04 June 2025)

### 1. Install system dependencies (build_master.sh included)

Run the command:

```bash
sudo apt update && sudo apt install -y \
  build-essential cmake git pkg-config \
  libboost-all-dev libsuitesparse-dev \
  libyaml-cpp-dev libglew-dev libgl1-mesa-dev libegl1-mesa-dev \
  libxkbcommon-dev libglfw3-dev libpython3-dev libpython2.7-dev \
  libjpeg-dev libpng-dev libtiff-dev libavcodec-dev \
  libavformat-dev libswscale-dev libgtk2.0-dev \
  qt5-default libqglviewer-dev-qt5 python2 libassimp-dev \
  libwxgtk3.0-gtk3-dev freeglut3-dev python-numpy
```

### 2. Build all components

In the project root:

```bash
bash build_master.sh
```

> 💡 If any part fails, go to `depends/<module>/` and run `bash build.sh` manually to debug.

---

## ⚙️ Runtime Feature Control (No Recompilation)

To disable points or lines **at runtime**, export these variables before launching:

```bash
export PLSAM_NO_POINTS=1   # Disable point features
export PLSAM_NO_LINES=1    # Disable line features
```

No need to modify `config.cpp` or recompile — switch modes on the fly!

---

## 🗂️ Dataset Setup

### 1. Export your dataset root path

```bash
export DATASETS_DIR=/your/path/to/dataset
```

### 2. Copy the appropriate config YAML

For example, if you're using KITTI sequence 00:

```bash
cp config/kitti.yaml $DATASETS_DIR/kitti/00/dataset_params.yaml
```

### 3. Set the runtime library path (Build_master.sh included)

```bash
export LD_LIBRARY_PATH=$HOME/pl-slam/installs/lib
```

---

## ▶️ Running

From the `build/` directory:

```bash
./plslam_dataset kitti/00           # Run SLAM only
./plstvo_dataset kitti/00           # Run SLAM + Trajectory Evaluation (GT required)
```

---

## 📤 Output

By default, PL-SLAM does **not output trajectory** to file.

To save poses (e.g., TUM format), you can manually add output logic in `plslam_dataset.cpp` or implement a `SaveTrajectoryTUM()` method inside the `PL_SLAM` class.

---

## 📁 Directory Structure

```
PL-SLAM-Compat/
├── build_master.sh        # Master build script
├── build/                 # Final executables
├── depends/               # All third-party sources and build.sh scripts
│   ├── eigen/
│   ├── opencv/
│   ├── g2o/
│   ├── mrpt/
│   └── stvo-pl/
├── config/                # Dataset YAMLs
├── installs/              # Install prefix for built libraries
└── ...
```

---

## 🧩 Compatibility

- Ubuntu 20.04 LTS on WSL2 tested  
- Requires ~5GB free disk space (More required for datasets) 
- Recommended: 4+ cores and 8GB RAM  

---

## 📜 License

This project follows the original [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.html).  
All dependencies and subcomponents retain their original licenses.



# PL-SLAM #

This code contains an algorithm to compute stereo visual SLAM by using both point and line segment features.

**Authors:** [Ruben Gomez-Ojeda](http://mapir.isa.uma.es/mapirwebsite/index.php/people/164-ruben-gomez), [Francisco Angel Moreno](http://mapir.isa.uma.es/mapirwebsite/index.php/people/199-francisco-moreno-due%C3%B1as), [Davide Scaramuzza](http://rpg.ifi.uzh.ch/people_scaramuzza.html), and [Javier Gonzalez-Jimenez](http://mapir.isa.uma.es/mapirwebsite/index.php/people/95-javier-gonzalez-jimenez)

**Related publication:** [*PL-SLAM: a Stereo SLAM System through the Combination of Points and Line Segments*](http://mapir.isa.uma.es/mapirwebsite/index.php/people/164-ruben-gomez)

If you use PL-SLAM in your research work, please cite:

    @article{gomez2017pl,
      title   = {{PL-SLAM: a Stereo SLAM System through the Combination of Points and Line Segments}},
      author  = {Gomez-Ojeda, Ruben and Moreno, Francisco-Angel and Scaramuzza, Davide and Gonzalez-Jimenez, Javier},
      journal = {arXiv preprint arXiv:1705.09479},
      year    = {2017}
}

The pdf file can be found at [https://arxiv.org/abs/1705.09479](https://arxiv.org/abs/1705.09479).

[![PL-SLAM](https://img.youtube.com/vi/-lCTf_tAxhQ/0.jpg)](https://www.youtube.com/watch?v=-lCTf_tAxhQ)

**Previous publications:**

[Gomez-Ojeda, R., Briales, J., & Gonzalez-Jimenez, J. (2016, October). PL-SVO: Semi-direct monocular visual odometry by combining points and line segments. In Intelligent Robots and Systems (IROS), 2016 IEEE/RSJ International Conference on (pp. 4211-4216). IEEE.](http://mapir.isa.uma.es/rgomez/publications/iros16plsvo.pdf)

[Gomez-Ojeda, R., & Gonzalez-Jimenez, J. (2016, May). Robust stereo visual odometry through a probabilistic combination of points and line segments. In Robotics and Automation (ICRA), 2016 IEEE International Conference on (pp. 2521-2526). IEEE.](http://mapir.isa.uma.es/rgomez/publications/icra16plsvo.pdf).

**License:**

The provided code is published under the General Public License Version 3 (GPL v3). More information can be found in the "LICENSE" also included in the repository.

Please do not hesitate to contact the authors if you have any further questions.


## 1. Prerequisites and dependencies

### OpenCV 3.0.0
It can be easily found at http://opencv.org. 
In the case of line segments, we have modified the *line_descriptor* from the *opencv_contrib* 
[repository](https://github.com/Itseez/opencv_contrib), included in the *3rdparty* folder.

### Eigen3
http://eigen.tuxfamily.org

### Boost
Installation on Ubuntu:
```
sudo apt-get install libboost-dev
```

### YAML
Installation on Ubuntu:
```
sudo apt-get install libyaml-dev
```

### MRPT (Optional)
In case of using the provided representation. 
```
sudo apt-get install libmrpt-dev
```

Download and install instructions can be also found at: http://www.mrpt.org/ .

### Line descriptor (in 3rdparty folder)
We have modified the [*line_descriptor*](https://github.com/opencv/opencv_contrib/tree/master/modules/line_descriptor) module from the [OpenCV/contrib](https://github.com/opencv/opencv_contrib) library (both BSD) which is included in the *3rdparty* folder.


## 2. Configuration and generation

Executing the file *build.sh* will configure and generate the *line_descriptor* and *DBoW2* modules, uncompress the vocabulary files, and then will configure and generate the *PL-SLAM* library for which we generate: **libplslam.so** in the lib folder, and the applications **plstvo_dataset** and **plslam_dataset** that works with our dataset format (explained in the next section).


## 3. Dataset format and usage

The **plslam_dataset** (and **plstvo_dataset**)  basic usage is: 
```
./plslam_dataset  <dataset_path>  
```

where *<dataset_path>* refers to the sequence folder relative to the environment variable *${DATASETS_DIR}* that must be previously set. That sequence folder must contain the dataset configuration file named **dataset_params.yaml** following the examples in **pl-slam/config**, where **images_subfolder_{lr}** refers to the left and right image subfolders.

