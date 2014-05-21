docker-smuggle
==============

Smuggle a process into a running Docker container!

Usage
-----

    $ docker-smuggle CONTAINER [COMMAND ARGS ...]

If no command is given, a shell is started.

Installation
------------

If have a reasonably recent util-linux that includes an `nsenter`
command, you're lucky! Just copy `docker-smuggle` somewhere into your
`$PATH` (such as `/usr/local/bin/`) and you're good to go.

If you're on a system that ships with old util-linux, and this system
is Ubuntu, run `make` to build a deb package with nsenter and
docker-smuggle.

Build needs Docker, wget, and Ruby with Bundler. By default the
package is build from `ubuntu:12.04` image; if you want to base your
build off a different image, run `make BUILD_IMAGE=ubuntu:14.04` or
something similar.

Have fun!
