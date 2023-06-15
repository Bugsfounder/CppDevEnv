FROM ubuntu:latest


RUN apt update -y && apt install -y tcl && apt install git -y

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


