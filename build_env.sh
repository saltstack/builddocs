#!/bin/bash -ex

# LATEST_RELEASE is latest point release (3000.1), it shows up in the tabs on the page here: https://docs.saltstack.com/en/latest/contents.html
# PREVIOUS_RELEASE is latest point release from previous major release (2019.2.3), it shows up in the tabs on the page here: https://docs.saltstack.com/en/latest/contents.html
# PREVIOUS_RELEASE_DIR is the previous major release folder (2019.2), it is the link that the first tab redirects to on https://docs.saltstack.com/en/latest/contents.html (https://docs.saltstack.com/en/2019.2/)
# See https://github.com/saltstack/salt/blob/master/doc/conf.py for more information

export LATEST_RELEASE='3007.0'
export PREVIOUS_RELEASE="${PREVIOUS_RELEASE:-3006.8}"
export PREVIOUS_RELEASE_DIR="${PREVIOUS_RELEASE_DIR:-3006}"

mkdir -p /usr/share/fonts/truetype
mkdir -p /usr/share/fonts/opentype
cp -rfv builddocs/files/fonts/truetype/* /usr/share/fonts/truetype/
cp -rfv builddocs/files/fonts/opentype/* /usr/share/fonts/opentype/
fc-cache -f -v
git clone --depth 1 -b "${DOC_BRANCH}" https://github.com/saltstack/salt /root/salt
python3 -m venv venv
# shellcheck disable=SC1091
. venv/bin/activate
pip install -U pip setuptools wheel
(pip install -r /root/salt/requirements/static/ci/py3.8/docs.txt && pip install -r /root/salt/requirements/static/pkg/py3.8/linux.txt) || pip install -r /root/salt/requirements/static/ci/py3.8/docs.txt || pip install -r /root/salt/requirements/static/py3.8/docs.txt || (pip install distro && pip install -r /root/salt/requirements/static/py3.7/docs.txt)
pip install jinja2==3.0.3
