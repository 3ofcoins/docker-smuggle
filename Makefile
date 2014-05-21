UTIL_LINUX_VERSION=2.24.2
PKG_REVISION=1
PKG_ARCH=$(shell dpkg-architecture -qDEB_HOST_ARCH)

UTIL_LINUX_TARBALL=download/util-linux-$(UTIL_LINUX_VERSION).tar.gz
PKG_FILE=docker-smuggle_$(UTIL_LINUX_VERSION)-$(PKG_REVISION)_$(PKG_ARCH).deb

all: $(PKG_FILE)

$(PKG_FILE): bin/fpm destroot/bin/nsenter
	fpm -s dir -t deb -C destroot --prefix /usr \
	    -n docker-smuggle \
	    -v $(UTIL_LINUX_VERSION) \
	    --iteration $(PKG_REVISION) \
	    --architecture $(PKG_ARCH) \
	    --url https://github.com/3ofcoins/docker-smuggle \
	    --maintainer 'Maciej Pasternacki <maciej@3ofcoins.net>' \
	    --vendor 'Maciej Pasternacki <maciej@3ofcoins.net>' \
	    bin/nsenter bin/docker-smuggle share/man/man1/nsenter.1

bin/fpm: Gemfile Gemfile.lock
	bundle install --binstubs

$(UTIL_LINUX_TARBALL):
	mkdir -p download
	wget -O "$@" "https://www.kernel.org/pub/linux/utils/util-linux/v$(shell echo $(UTIL_LINUX_VERSION) | grep -o '^[1-9][0-9]*\.[1-9][0-9]*')/util-linux-$(UTIL_LINUX_VERSION).tar.gz"

destroot/bin/nsenter: $(UTIL_LINUX_TARBALL) compile.sh docker-smuggle
	docker run --volume=`pwd`:/work --workdir=/work --rm ubuntu:12.04 ./compile.sh $(UTIL_LINUX_TARBALL)

clean:
	rm -rf download destroot bin pkgroot
