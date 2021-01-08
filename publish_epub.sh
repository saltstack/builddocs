#!/bin/bash -ex

if [ -z "${WEBSITE_USER}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_USER"
	exit 1
fi

if [ -z "${WEBSITE_PASSWORD}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_PASSWORD"
	exit 1
fi

if [ -z "${WEBSITE_RELEASE}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_RELEASE"
	exit 1
fi

if [ -z "${WEBSITE_POINT_RELEASE}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_POINT_RELEASE"
	exit 1
fi

. ./publish_env.sh
lftp -c "open -u ${WEBSITE_USER},${WEBSITE_PASSWORD} -p 2222 sftp://saltstackdocs.wpengine.com;mkdir -f -p /en/epub;put -e -O /en/epub /root/salt/doc/_build/epub/Salt.epub -o Salt-${WEBSITE_POINT_RELEASE}.epub"
RCLONE_CONFIG_S3_TYPE=s3 RCLONE_CONFIG_S3_PROVIDER=AWS RCLONE_CONFIG_S3_ENV_AUTH=true RCLONE_CONFIG_S3_REGION=us-west-2 RCLONE_CONFIG_S3_LOCATION_CONSTRAINT=us-west-2 RCLONE_CONFIG_S3_ACL=public-read rclone copy -c -v "./public/en/epub/Salt-${WEBSITE_POINT_RELEASE}.epub" s3:docs.saltproject.io/en/epub/
