#!/bin/bash -ex

. ./build_env.sh
make -C /root/salt/doc epub
mkdir -p ./public/en/epub/
cp /root/salt/doc/_build/epub/Salt.epub ./public/en/epub/Salt-${WEBSITE_POINT_RELEASE}.epub
