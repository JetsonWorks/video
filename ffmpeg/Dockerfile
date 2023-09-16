# the included ffmpeg will stop recording after about 30 seconds, but freshly-compiled is good
FROM ubuntu:18.04

RUN apt update && apt install -y git
RUN git clone https://git.ffmpeg.org/ffmpeg.git
RUN apt install -y make gcc pkg-config yasm
WORKDIR ffmpeg
ARG ffmpegVer
RUN git checkout $ffmpegVer
RUN ./configure && make -j4 install && make clean
