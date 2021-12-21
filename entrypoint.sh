#!/bin/sh

set -x

# configure script to call original entrypoint
set -- /tini -- /usr/bin/signal-desktop "$@"

if [ "$(id -u)" = "0" ]; then
	groupmod -g ${GID} -o user
	usermod -u ${UID} -o user

	# Add call to gosu to drop from root user to signal user
	# when running original entrypoint
	set -- gosu user "$@"
fi

# replace the current pid 1 with original entrypoint
exec "$@"

