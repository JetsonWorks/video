# Introduction

This is a simple video streaming and recording setup for
the [Jetson Nano](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-nano/education-projects/),
using [MediaMTX](https://github.com/bluenviron/mediamtx) as the media server.

## Features

* Publish live streams to the server
* Optional on-board recording of any camera
* Uses Docker for convenience

The sample MediaMTX configuration uses [GStreamer](https://gstreamer.freedesktop.org/) pipelines
(using [gst-launch-1.0](https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c)) to
capture, convert, and publish the video from the camera to MediaMTX.
Your pipeline(s) will vary based on your device.
MediaMTX also supports FFmpeg and other software that can publish an RTSP stream.

## Requirements

* A Jetson Nano
   * Or a similar SBC of your choice, compatible with PyTorch 1.10.0 on CUDA 10.2
* 32 GB storage for OS, apps, and recordings

# Setup

This project uses Docker Compose, which is not installed by default.
Please follow the instructions in [this guide](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) to add the Apt repository and install docker-compose-plugin.

Clone this repo on your Jetson and pull the Docker images.

```sh
docker compose pull
```

Video is captured using mediamtx, which requires some configuration to match your device capabilities.
The proxy uses a bind-mounted directory for configuration.
While running, you may update mediamtx.yml, and mediamtx will hot-reload the configuration once you save your changes.
By default, this directory is /var/media on the host and /media in the container.

The default sample configuration will be installed as /var/media/mediamtx.yml when the rtspproxy service starts.
See [MediaMTX](https://github.com/bluenviron/mediamtx),
[gst-launch-1.0](https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c),
and other guides for help configuring paths in mediamtx.yml.

# Usage

1. Start the media server

```sh
docker compose up rtspproxy
```

## Viewing

You can open video streams using software such as _VLC_:

```sh
vlc --network-caching=50 rtsp://jetson:8554/outdoor
```

or _GStreamer_:

```sh
gst-play-1.0 rtsp://jetson:8554/outdoor
```

or _FFmpeg_:

```sh
ffmpeg -i rtsp://jetson:8554/outdoor
```

Be sure to use the correct URL, as defined in mediamtx.yml.

You may also want to set up another MediaMTX server as a proxy for better performance.
For example, multiple clients may receive higher quality streams from your proxy than directly from your Jetson,
especially if your Jetson is connected wirelessly.

## Recording

If you would like to record from one or more cameras (via the proxy), you could choose to set up corresponding Docker services for
convenience.
Two have been provided in docker-compose.yaml, for reference.
Update the camName and camUrl environment variables to match your mediamtx.yml definition.

By default, the recorder stores one-minute videos in the named subdirectory (e.g. /media/videos/outdoor).
To prevent the recorder from filling up your filesystem, when the maximum number of videos has been reached, the oldest
videos are removed.

The video location, length, and other configuration is stored in the `.env` file.

Once configured, build and run the recording service:

```sh
docker compose build outdoor
docker compose up outdoor
```

Replace "outdoor" with the name of the Docker service you configured for your camera.

For better performance during recording, the recorder uses a newer version of ffmpeg.
The recording service depends on the proxy service, which means the proxy will automatically be started if not already
running.
So, to start the proxy and the recorder, you may simply:

```sh
docker compose up -d outdoor
```

**Enjoy!**

