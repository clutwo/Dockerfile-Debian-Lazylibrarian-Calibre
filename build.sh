#!/bin/bash

docker build --no-cache -t calibre-ll-arm64 --build-arg "UID=1000" --build-arg "GID=1000" .
