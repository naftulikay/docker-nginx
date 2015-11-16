#!/bin/sh

set -e

nginx_binary="$(which nginx)"

# nginx will switch users automatically because it's awesome
exec $nginx_binary -g 'daemon off;'
