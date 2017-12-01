#!/bin/bash

docker run -it --rm -e "PULSE_SERVER=tcp:$(hostname -i):4713" \
	-e "PULSE_COOKIE_DATA=$(pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*')" \
	-v "$PWD/media:/var/lib/mopidy/media:ro" \
	-v "$PWD/local:/var/lib/mopidy/local" \
	-p 6600:6600 -p 6680:6680 -p 8000:8000 \
	mopidy /bin/bash

