#!/usr/bin/env pwsh

set -e

choco install opencv

yum install -y epel-release git gcc gcc-c++ cmake3 qt5-qtbase-devel \
    python python-devel python-pip cmake python-devel python34-numpy \
    gtk2-devel libpng-devel jasper-devel openexr-devel libwebp-devel \
    libjpeg-turbo-devel libtiff-devel libdc1394-devel tbb-devel numpy \
    eigen3-devel gstreamer-plugins-base-devel freeglut-devel mesa-libGL \
    mesa-libGL-devel boost boost-thread boost-devel libv4l-devel

mkdir ~/opencv_build && cd ~/opencv_build
git clone https://github.com/opencv/opencv.git --depth 1 --branch  4.4.0
git clone https://github.com/opencv/opencv_contrib.git --depth 1 --branch  4.4.0
cd ~/opencv_build/opencv && mkdir build && cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..

make

sudo make install

sudo ln -s /usr/local/lib64/pkgconfig/opencv4.pc /usr/share/pkgconfig/

sudo ldconfig

pkg-config --modversion opencv4
