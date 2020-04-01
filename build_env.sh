#!/bin/bash -ex

# LATEST_RELEASE is latest point release (3000.1), it shows up in the tabs on the page here: https://docs.saltstack.com/en/latest/contents.html
# PREVIOUS_RELEASE is latest point release from previous major release (2019.2.3), it shows up in the tabs on the page here: https://docs.saltstack.com/en/latest/contents.html
# PREVIOUS_RELEASE_DIR is the previous major release folder (2019.2), it is the link that the first tab redirects to on https://docs.saltstack.com/en/latest/contents.html (https://docs.saltstack.com/en/2019.2/)
# See https://github.com/saltstack/salt/blob/master/doc/conf.py for more information

export LATEST_RELEASE='3000.1'
export PREVIOUS_RELEASE='2019.2.3'
export PREVIOUS_RELEASE_DIR='2019.2'

apt-get update
apt-get install -y python3-pip git fontconfig make
pip3 install sphinx==2.0.1
mkdir -p /usr/share/fonts/truetype
mkdir -p /usr/share/fonts/opentype
cp -rfv builddocs/files/fonts/truetype/* /usr/share/fonts/truetype/
cp -rfv builddocs/files/fonts/opentype/* /usr/share/fonts/opentype/
fc-cache -f -v
git clone --depth 1 -b ${DOC_BRANCH} https://github.com/saltstack/salt /root/salt
