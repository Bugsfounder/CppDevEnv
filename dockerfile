FROM ubuntu:latest


RUN apt update -y && apt install -y tcl && apt install git -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends autoconf wget build-essential \
    git pkg-config curl automake libtool curl g++ libopencv-dev snap pkg-config unzip \
    libzmq5 libavfilter-dev libavdevice-dev libswresample-dev libswscale-dev libmsgpack-dev ninja-build libsqlite3-dev \
    && apt-get clean

RUN apt-get -y install zip xauth python3 openssh-client pip
RUN apt-get install -y apt-transport-https ca-certificates gnupg software-properties-common net-tools
RUN mkdir -p /home/react-vision/
RUN apt-get -y install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
RUN apt-get install -y python3-venv 
RUN python3 -m pip install virtualenv \
    && python3 -m pip install grpcio \
    && python3 -m pip install grpcio-tools
RUN apt-get -y install libva-dev libmfx-dev ffmpeg



RUN apt-get install libgtest-dev -y

#=====================================
# Install cmake -latest
#=====================================
RUN apt-get install -y apt-transport-https ca-certificates gnupg software-properties-common 
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null && \
    apt-get update && \
    rm /usr/share/keyrings/kitware-archive-keyring.gpg && \
    apt-get install -y kitware-archive-keyring
RUN apt-get install -y cmake
RUN cmake --version

#======================================
# Install cppzmq
#======================================
RUN mkdir -p /home/react-vision/packages \
    && cd /home/react-vision/packages \
    && git clone https://github.com/zeromq/libzmq.git \
    && cd libzmq \
    && mkdir build && cd build \
    && cmake .. \
    && make -j install

#=======================================
# Install spdlog
# todo: add args to build tests off
#=======================================
RUN cd /home/react-vision/packages \
    && git clone https://github.com/gabime/spdlog.git \
    && cd /home/react-vision/packages/spdlog \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j  \
    && make install

# RUN apk add --no-cache bash

# WORKDIR /modules

# COPY /home/bugs/workspace/ReactVision/rv_utils/Communication ./modules 

# RUN chmod +x startup.sh 
# COPY startup.sh .
# RUN chmod +x startup.sh 

# ENTRYPOINT [ "/app/startup.sh" ]