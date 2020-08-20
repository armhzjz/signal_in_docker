#!/bin/bash

docker build --rm \
        --network=host \
        -t armhzjz/sigindock \
        .
