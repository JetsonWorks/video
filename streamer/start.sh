#!/bin/bash

cd $mediaMnt
if [ ! -f mediamtx.yml ]; then
  cp /root/mediamtx.yml .
fi
/root/mediamtx mediamtx.yml
