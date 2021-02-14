#!/usr/bin/env bash

set -e

pip install -r dev-requirements.txt

brew update

mkdir ~/opencv_build && cd ~/opencv_build
git clone https://github.com/opencv/opencv.git --depth 1 --branch 4.4.0
git clone https://github.com/opencv/opencv_contrib.git --depth 1 --branch 4.4.0
cd ~/opencv_build/opencv && mkdir build && cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ..

make

sudo make install

sudo ln -s /usr/local/lib64/pkgconfig/opencv4.pc /usr/share/pkgconfig/

sudo ldconfig

pkg-config --modversion opencv4
