FROM jupyter/datascience-notebook

MAINTAINER izumin5210 <masayuki@izumin.info>

USER root

RUN apt-get update \
    && apt-get install -y \
        cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN wget https://github.com/Itseez/opencv/archive/3.0.0.zip -O opencv3.zip \
    && unzip -q opencv3.zip \
    && mv opencv-3.0.0 opencv \
    && rm opencv3.zip \
    && wget https://github.com/Itseez/opencv_contrib/archive/3.0.0.zip -O opencv_contrib3.zip \
    && unzip -q opencv_contrib3.zip \
    && mv opencv_contrib-3.0.0 opencv_contrib \
    && rm opencv_contrib3.zip \
    && mkdir opencv/build \
    && cd opencv/build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_TBB=ON \
          -D BUILD_PYTHON_SUPPORT=ON \
          -D WITH_V4L=ON \
          -D INSTALL_PYTHON_EXAMPLES=ON \
          -D BUILD_EXAMPLES=ON \
          -D BUILD_DOCS=ON \
          -D OPENCV_EXTRA_MODULES_PATH=opencv_contrib/modules \
          -D WITH_XIMEA=YES \
          -D WITH_FFMPEG=YES \
          -D WITH_PVAPI=YES \
          -D WITH_GSTREAMER=YES \
          -D WITH_TIFF=YES \
          -D WITH_OPENCL=YES \
          -D PYTHON2_EXECUTABLE=/opt/conda/envs/python2/bin/python \
          -D PYTHON2_INCLUDE_DIR=/opt/conda/envs/python2/include/python2.7 \
          -D PYTHON2_LIBRARIES=/opt/conda/envs/python2/lib/libpython2.7.so \
          -D PYTHON2_PACKAGES_PATH=/opt/conda/envs/python2/lib/python2.7/site-packages \
          -D PYTHON2_NUMPY_INCLUDE_DIRS=/opt/conda/envs/python2/lib/python2.7/site-packages/numpy/core/include/ \
          -D BUILD_opencv_python3=ON \
          -D PYTHON3_EXECUTABLE=/opt/conda/bin/python \
          -D PYTHON3_INCLUDE_DIR=/opt/conda/include/python3.5m/ \
          -D PYTHON3_LIBRARY=/opt/conda/lib/libpython3.so \
          -D PYTHON_LIBRARY=/opt/conda/lib/libpython3.so \
          -D PYTHON3_PACKAGES_PATH=/opt/conda/lib/python3.5/site-packages \
          -D PYTHON3_NUMPY_INCLUDE_DIRS=/opt/conda/lib/python3.5/site-packages/numpy/core/include/ \
          .. \
    && make -j4 \
    && make install \
    && sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' \
    && ldconfig \
    && cd ../.. \
    && rm -rf opencv opencv_contrib

## Switch back to jupyter user
USER jovyan

VOLUME /notebooks
WORKDIR /notebooks
