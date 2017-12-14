#!/bin/sh

set -e

chown -R mopidy:mopidy /var/lib/mopidy/.local /var/lib/mopidy/.config /var/lib/mopidy/local /var/lib/mopidy/playlists
if [ "$1" = "start" ];then
	exec su-exec mopidy mopidy
fi

if [ "$1" = "scan" ];then
	exec su-exec mopidy mopidy local scan
fi

if [ "$1" = "clear" ];then
	exec su-exec mopidy mopidy local clear
fi

exec "$@"
