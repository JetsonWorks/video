# the included ffmpeg will stop recording after about 30 seconds, but freshly-compiled is good
ARG registry
FROM ${registry}video/ffmpeg as ffmpeg

FROM ubuntu:18.04

COPY --from=ffmpeg /usr/local/share/ffmpeg /usr/local/share/
COPY --from=ffmpeg /usr/local/include/* /usr/local/include/
COPY --from=ffmpeg /usr/local/lib/* /usr/local/lib/
COPY --from=ffmpeg /usr/local/bin/* /usr/local/bin/

COPY recorder.sh /root/

CMD /root/recorder.sh
