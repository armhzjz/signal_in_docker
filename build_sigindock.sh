#!/bin/bash

docker build --rm \
        --network=host \
        -t armhzjz/signal-in-docker:latest \
        .
