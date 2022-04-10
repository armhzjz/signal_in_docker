#!/bin/bash

docker build  --network host --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg USER=signaluser -f Dockerfile -t armhzjz/signaldock .
