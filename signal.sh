#!/bin/bash

docker run -d --rm --name signaldock \
	--net=host \
	-e UID=$(id -u) \
	-e GID=$(id -g) \
	-v ${HOME}/.Xauthority:/home/user/.Xauthority armhzjz/signaldock

