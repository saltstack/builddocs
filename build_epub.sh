#!/bin/bash -ex

. ./build_env.sh
make -C /root/salt/doc epub
mkdir -p ./public/epub/
cp /root/salt/doc/_build/epub/Salt.epub "./public/epub/Salt-${WEBSITE_POINT_RELEASE}.epub"
