#!/bin/sh

set -e

if [ ! -f "/etc/nginx/nginx.conf" ]; then
    # if /etc/nginx/nginx.conf doesn't exist, it's probably mounted as a
    # volume, so extract the default config into that folder
    logger -s -t nginx "Extracting default config into /etc/nginx..."
    tar xzf /var/lib/nginx/nginx-default-config.tar.gz -C /etc
fi
