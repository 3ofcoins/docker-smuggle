#!/bin/sh
set -e -x
export DEBIAN_FRONTEND=noninteractive
workroot="`pwd`"

apt-get update
apt-get install --yes build-essential < /dev/null
apt-get build-dep --yes util-linux < /dev/null

rm -rf destroot
mkdir -p destroot/src
tar -C destroot/src -xzf "$1"

cd destroot/src/`basename "$1" .tar.gz`
./configure --prefix="$workroot/destroot" --without-ncurses
make
make install
install -m 0755 "$workroot/docker-smuggle" "$workroot/destroot/bin/docker-smuggle"
