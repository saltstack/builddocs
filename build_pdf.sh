#!/bin/bash -ex

. ./build_env.sh
make -C /root/salt/doc pdf

echo "### Head 200 lines of log ###"
head -n 200 /root/salt/doc/_build/latex/Salt.log
echo "### Tail 200 lines of log ###"
tail -n 200 /root/salt/doc/_build/latex/Salt.log

echo "### Testing PDF ###"
pdfinfo /root/salt/doc/_build/latex/Salt.pdf
mkdir -p ./public/pdf/
cp /root/salt/doc/_build/latex/Salt.pdf "./public/pdf/Salt-${WEBSITE_POINT_RELEASE}.pdf"
