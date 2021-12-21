#!/bin/bash

docker run -it --rm --name signaldock \
	--net=host \
	-e UID=$(id -u) \
	-e GID=$(id -g) \
	-v ${HOME}/.Xauthority:/home/user/.Xauthority armhzjz/signaldock

