Containerized [**Mopidy**](https://www.mopidy.com/) music server with support for [MPD clients](https://docs.mopidy.com/en/latest/clients/mpd/) and [HTTP clients](https://docs.mopidy.com/en/latest/ext/web/#ext-web).

Originally a fork of https://github.com/wernight/docker-mopidy, but has been highly modified since.

### Features

  * Based on `Debian` official (`debian:stretch-slim`)
  * Streaming ability by using an `Icecast` server
  * Extremely easy to add new plugins through PR, most are just a single line addition to the `Dockerfile`.
  * Backend extensions:
    * Standards: DLNA(dLeyna)
    * [Mopidy-Spotify](https://docs.mopidy.com/en/latest/ext/backends/#mopidy-spotify) for **[Spotify](https://www.spotify.com/us/)** (Premium)
    * [Mopidy-GMusic](https://docs.mopidy.com/en/latest/ext/backends/#mopidy-gmusic) for **[Google Play Music](https://play.google.com/music/listen)**
    * [Mopidy-SoundClound](https://docs.mopidy.com/en/latest/ext/backends/#mopidy-soundcloud) for **[SoundCloud](https://soundcloud.com/stream)**
    * [Mopidy-YouTube](https://docs.mopidy.com/en/latest/ext/backends/#mopidy-youtube) for **[YouTube](https://www.youtube.com)**
    * AudioAddict (difm)
    * More
  * Frontend extensions:
    * Standards: MPD, HTTP
    * [Mopidy-Scrobbler](http://mopidy.readthedocs.io/en/latest/ext/frontends/#mopidy-scrobbler)
    * [Mopidy-API-Explorer](http://mopidy.readthedocs.io/en/latest/ext/web/#mopidy-api-explorer)
    * [Mopidy-Local-Images](http://mopidy.readthedocs.io/en/latest/ext/web/#mopidy-local-images)
    * [Mopidy-Material-Webclient](http://mopidy.readthedocs.io/en/latest/ext/web/#mopidy-material-webclient)
    * [Mopidy-Mopify](http://mopidy.readthedocs.io/en/latest/ext/web/#mopidy-mopify)
    * [Mopidy-MusicBox-Webclient](http://mopidy.readthedocs.io/en/latest/ext/web/#mopidy-musicbox-webclient)
    * [Mopidy-Spotmop](http://mopidy.readthedocs.io/en/latest/ext/web/#mopidy-spotmop)
    * [Mopidy-Moped](https://docs.mopidy.com/en/latest/ext/web/#mopidy-moped)
    * Mopidy-Webhooks
    * Mopidy-Notifier
    * More
  * Runs as `app` user inside the container for security.

You may install additional [backends](https://docs.mopidy.com/en/latest/ext/backends/) or [frontends](https://docs.mopidy.com/en/latest/ext/frontends/).


### Usage

#### PulseAudio over network

First to make [audio from from within a Docker container](http://stackoverflow.com/q/28985714/167897), you should enable [PulseAudio over network](https://wiki.freedesktop.org/www/Software/PulseAudio/Documentation/User/Network/); so if you have X11 you may for example do:

 1. Install [PulseAudio Preferences](http://freedesktop.org/software/pulseaudio/paprefs/). Debian/Ubuntu users can do this:

        $ sudo apt-get install paprefs

 2. Launch `paprefs` (PulseAudio Preferences) > "*Network Server*" tab > Check "*Enable network access to local sound devices*" (you may check "*Don't require authentication*" to avoid mounting cookie file described below).

 3. Restart PulseAudio

        $ sudo service pulseaudio restart

    or

        $ pulseaudio -k
        $ pulseaudio --start

    On some distributions, it may be necessary to completely restart your computer. You can confirm that the settings have successfully been applied running `pax11publish | grep -Eo 'tcp:[^ ]*'`. You should see something like `tcp:myhostname:4713`.

#### General usage

Modify the `docker-compose` files according to your needs.


See [mopidy's command](https://docs.mopidy.com/en/latest/command/) for possible additional options.

Most elements are optional (see some examples below). Replace `BLAH` accordingly if needed, or disable services (e.g., `-o spotify/enabled=false`):

  * For *Spotify* you'll need a *Premium* account.
  * For *Google Music* use your Google account (if you have *2-Step Authentication*, generate an [app specific password](https://security.google.com/settings/security/apppasswords)).
  * For *SoundCloud*, just [get a token](https://www.mopidy.com/authenticate/) after registering.
  * For *AudioAddict*, you need a premium account if you want to set the quality past 64k, otherwise account is optional.

Ports:

  * 6600 - MPD server (if you use for example ncmpcpp client)
  * 6680 - HTTP server (if you use your browser as client)
  * 8000 - Icecast server
