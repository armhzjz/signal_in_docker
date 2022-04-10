#!/bin/sh

set -x

# configure script to call original entrypoint
set -- /tini -- /usr/bin/signal-desktop "$@"

if [ "$(id -u)" = "0" ];then
	# fix user ID and group ID of signaluser to the local user's
	groupmod -g ${GID} -o signaluser
	usermod -u ${UID} -o signaluser

	# change user owner of the signal user data directory
	chown -R signaluser:signaluser /home/signaluser/.config/Signal

	# Add call to gosu to drop from root user to signaluser user
	# when running original entrypoint
	set -- gosu signaluser "$@"
fi

# replace the current pid 1 with original entrypoint
exec "$@"

