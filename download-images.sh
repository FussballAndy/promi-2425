#! /usr/bin/env bash
mkdir -p ./images
xargs -P 10 -a image-sources.txt -L1 bash -c 'wget -t 10 $1 -O images/$0'
