# Copyright (c) 2022-2023, AllWorldIT.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.


FROM registry.conarx.tech/containers/nginx-php/edge


ARG VERSION_INFO=
LABEL org.opencontainers.image.authors   "Nigel Kukard <nkukard@conarx.tech>"
LABEL org.opencontainers.image.version   "edge"
LABEL org.opencontainers.image.base.name "registry.conarx.tech/containers/nginx-php/edge"


ENV PHP_NAME=php81

ENV PRIVATEBIN_VER=1.5.1


RUN set -eux; \
	true "Check PHP version"; \
	if [ ! -d "/etc/$PHP_NAME" ]; then echo "PHP needs updating, '/etc/$PHP_NAME' does not exist"; false; fi; \
	true "PrivateBin requirements"; \
	mkdir /var/www/privatebin-data; \
	chown www-data:www-data \
		/var/www/privatebin-data; \
	chmod 0755 \
		/var/www/privatebin-data; \
	true "Cleanup"; \
	rm -f /var/cache/apk/*

RUN set -eux; \
	mkdir -p build; \
	cd build; \
	wget "https://github.com/PrivateBin/PrivateBin/archive/refs/tags/${PRIVATEBIN_VER}.tar.gz" -O "PrivateBin-${PRIVATEBIN_VER}.tar.gz"; \
	tar -xf "PrivateBin-${PRIVATEBIN_VER}.tar.gz"; \
	\
	cd "PrivateBin-${PRIVATEBIN_VER}"; \
	\
	true "Patching"; \
# Strip version from main page
	sed -i -e 's,echo \$VERSION,echo "",' tpl/bootstrap.php; \
	\
	true "Check the checksum of the config to see if we have to update"; \
	CFG_SHA256=$(sha256sum cfg/conf.sample.php | awk '{print $1}'); \
	if [ "$CFG_SHA256" != "c57b7df1a44258a12f819bce59b1f3d4b8c9285b1f93a920ce9aaa57d362c678" ]; then echo "ERROR: CONFIG CHANGED AND POSSIBLY UPDATING: $CFG_SHA256"; exit 1; fi; \
	\
	mv -v css i18n img index.php js lib robots.txt tpl vendor \
		/var/www/html; \
	mkdir /var/www/html/cfg; \
	\
	cd ../..; \
	rm -rf build; \
	\
	true "Remove Nginx PHP test init which overwrites index.php"; \
	rm -fv /usr/local/share/flexible-docker-containers/pre-init-tests.d/46-nginx-php.sh; \
	rm -fv /usr/local/share/flexible-docker-containers/tests.d/44-nginx.sh

COPY termbin/termbin.php /var/www/html


# PHP-FPM config
COPY etc/php/conf.d/30-fdc-privatebin.ini /etc/$PHP_NAME/conf.d/30-fdc-privatebin.ini
RUN set -eux; \
	chown root:root \
		/etc/$PHP_NAME/conf.d/30-fdc-privatebin.ini; \
	chmod 0644 \
		/etc/$PHP_NAME/conf.d/30-fdc-privatebin.ini


# PrivateBin
COPY etc/nginx/http.d/50_vhost_default.conf /etc/nginx/http.d
COPY usr/local/share/flexible-docker-containers/init.d/48-nginx-php-privatebin.sh /usr/local/share/flexible-docker-containers/init.d
COPY usr/local/share/flexible-docker-containers/tests.d/48-nginx-php-privatebin.sh /usr/local/share/flexible-docker-containers/tests.d
RUN set -eux; \
	true "Flexible Docker Containers"; \
	if [ -n "$VERSION_INFO" ]; then echo "$VERSION_INFO" >> /.VERSION_INFO; fi; \
	chown root:root \
		/var/www/html; \
	fdc set-perms


VOLUME ["/var/www/privatebin-data"]
