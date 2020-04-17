#!/bin/bash -ex

if [ -z "${WEBSITE_RELEASE}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_RELEASE"
	exit 1
fi

. ./build_env.sh
SALT_ON_SALTSTACK=true make -C /root/salt/doc html
rm -rf /root/salt/doc/_build/html/_sources
echo "ErrorDocument 404 /en/${WEBSITE_RELEASE}/404.html" > /root/salt/doc/_build/html/.htaccess

# The 404 page has relative links.  We may or may not want to just move these changes to the actual built docs in the future.
sed -i "s#\"contents.html#\"/en/${WEBSITE_RELEASE}/contents.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"faq.html#\"/en/${WEBSITE_RELEASE}/faq.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"genindex.html#\"/en/${WEBSITE_RELEASE}/genindex.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"glossary.html#\"/en/${WEBSITE_RELEASE}/glossary.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"home.html#\"/en/${WEBSITE_RELEASE}/home.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"_images#\"/en/${WEBSITE_RELEASE}/_images#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"index.html#\"/en/${WEBSITE_RELEASE}/index.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"py-modindex.html#\"/en/${WEBSITE_RELEASE}/py-modindex.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"ref#\"/en/${WEBSITE_RELEASE}/ref#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"salt-modindex.html#\"/en/${WEBSITE_RELEASE}/salt-modindex.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"search.html#\"/en/${WEBSITE_RELEASE}/search.html#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"security#\"/en/${WEBSITE_RELEASE}/security#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"_static#\"/en/${WEBSITE_RELEASE}/_static#g" /root/salt/doc/_build/html/404.html
sed -i "s#\"topics#\"/en/${WEBSITE_RELEASE}/topics#g" /root/salt/doc/_build/html/404.html

# Dealing with this bug: https://github.com/saltstack/salt/issues/52777
if [ -f /root/salt/doc/_build/html/py-modindex.html ] && [ ! -e /root/salt/doc/_build/html/salt-modindex.html ]
then
	cp -n /root/salt/doc/_build/html/py-modindex.html /root/salt/doc/_build/html/salt-modindex.html
fi

if [ ! -e /root/salt/doc/_build/html/salt-modindex.html ]
then
	echo "ERROR: salt-modindex.html is missing"
	exit 1
fi

if [ "${WEBSITE_RELEASE}" != "latest" ]
then
	echo '<meta http-equiv="refresh" content="0; url=contents.html" />' > /root/salt/doc/_build/html/index.html
fi
mkdir -p ./public/en/
rsync -a /root/salt/doc/_build/html/ ./public/en/${WEBSITE_RELEASE}/
