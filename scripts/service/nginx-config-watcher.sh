#!/bin/sh

set -e

# watch for changes in /etc/nginx and restart the service accordingly
exec /bin/bash -c 'while inotifywait -q -e modify -r /etc/nginx >/dev/null ; do
    logger -s -t nginx "NGINX config file changed, restarting NGINX."
    sv restart nginx ;
done'
