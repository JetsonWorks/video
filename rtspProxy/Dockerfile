ARG project
ARG tag
ARG inferenceImg
FROM ${project}ffmpeg${tag} as ffmpeg
# based on inference image for the nvidia packages
FROM ${inferenceImg} as inference

RUN apt update && apt upgrade -y --autoremove && apt install -y gstreamer1.0-tools gstreamer1.0-rtsp curl && apt clean

COPY --from=ffmpeg /usr/local/share/ffmpeg /usr/local/share/
COPY --from=ffmpeg /usr/local/include/* /usr/local/include/
COPY --from=ffmpeg /usr/local/lib/* /usr/local/lib/
COPY --from=ffmpeg /usr/local/bin/* /usr/local/bin/

ARG mediamtxVer
#ARG mediamtxUrl=https://github.com/bluenviron/mediamtx/releases/download/${mediamtxVer}/mediamtx_${mediamtxVer}_linux_arm64v8.tar.gz
ARG mediamtxUrl=https://github.com/bluenviron/mediamtx/files/12550577/mediamtx_v1.0.3-8-g6402e18_linux_arm64v8.tar.gz
WORKDIR /root
RUN curl -L $mediamtxUrl |tar zx mediamtx
COPY start.sh mediamtx.yml /root/

ARG mediaMnt
WORKDIR $mediaMnt
CMD /root/start.sh
