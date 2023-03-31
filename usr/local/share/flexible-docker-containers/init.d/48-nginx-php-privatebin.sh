#!/bin/bash
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


fdc_notice "Configuring PrivateBin"


#
# Main section
#

cat <<EOF > /var/www/html/cfg/conf.php
;<?php http_response_code(403); /*

[main]
EOF


if [ -n "$PRIVATEBIN_NAME" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) set a project name to be displayed on the website
name = '$PRIVATEBIN_NAME'

EOF
fi


if [ -n "$PRIVATEBIN_BASEPATH" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; The full URL, with the domain name and directories that point to the
; PrivateBin files, including an ending slash (/). This URL is essential to
; allow Opengraph images to be displayed on social networks.
basepath = '$PRIVATEBIN_BASEPATH'

EOF
fi


PRIVATEBIN_DISCUSSION="${PRIVATEBIN_DISCUSSION:-false}"
cat <<EOF >> /var/www/html/cfg/conf.php
; enable or disable the discussion feature, defaults to true
discussion = $PRIVATEBIN_DISCUSSION

EOF


PRIVATEBIN_OPENDISCUSSION="${PRIVATEBIN_OPENDISCUSSION:-false}"
cat <<EOF >> /var/www/html/cfg/conf.php
; preselect the discussion feature, defaults to false
opendiscussion = $PRIVATEBIN_OPENDISCUSSION

EOF


PRIVATEBIN_PASSWORD="${PRIVATEBIN_PASSWORD:-true}"
cat <<EOF >> /var/www/html/cfg/conf.php
; enable or disable the password feature, defaults to true
password = $PRIVATEBIN_PASSWORD

EOF


PRIVATEBIN_FILEUPLOAD="${PRIVATEBIN_FILEUPLOAD:-false}"
cat <<EOF >> /var/www/html/cfg/conf.php
; enable or disable the file upload feature, defaults to false
fileupload = $PRIVATEBIN_FILEUPLOAD

EOF


PRIVATEBIN_BURN_AFTER_READING_SELECTED="${PRIVATEBIN_BURN_AFTER_READING_SELECTED:-false}"
cat <<EOF >> /var/www/html/cfg/conf.php
; preselect the burn-after-reading feature, defaults to false
burnafterreadingselected = $PRIVATEBIN_BURN_AFTER_READING_SELECTED

EOF

PRIVATEBIN_DEFAULT_FORMATTER="${PRIVATEBIN_DEFAULT_FORMATTER:-plaintext}"
cat <<EOF >> /var/www/html/cfg/conf.php
; which display mode to preselect by default, defaults to "plaintext"
; make sure the value exists in [formatter_options]
; Options:
;   - plaintext
;   - syntaxhighlighting
;   - markdown
defaultformatter = "$PRIVATEBIN_DEFAULT_FORMATTER"

EOF

# ; (optional) set a syntax highlighting theme, as found in css/prettify/
# ; syntaxhighlightingtheme = "sons-of-obsidian"

PRIVATEBIN_SIZE_LIMIT="${PRIVATEBIN_SIZE_LIMIT:-10485760}"
cat <<EOF >> /var/www/html/cfg/conf.php
; size limit per paste or comment in bytes, defaults to 10 Mebibytes
sizelimit = $PRIVATEBIN_SIZE_LIMIT

EOF


PRIVATEBIN_TEMPLATE="${PRIVATEBIN_TEMPLATE:-bootstrap}"
cat <<EOF >> /var/www/html/cfg/conf.php
; template to include, default is "bootstrap" (tpl/bootstrap.php)
template = "$PRIVATEBIN_TEMPLATE"

EOF


if [ -n "$PRIVATEBIN_INFO" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) info text to display
; use single, instead of double quotes for HTML attributes
info = "$PRIVATEBIN_INFO"

EOF
fi


if [ -n "$PRIVATEBIN_NOTICE" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) notice to display
notice = "$PRIVATEBIN_NOTICE"
EOF
fi


PRIVATEBIN_LANGUAGE_SELECTION="${PRIVATEBIN_LANGUAGE_SELECTION:-false}"
cat <<EOF >> /var/www/html/cfg/conf.php
; by default PrivateBin will guess the visitors language based on the browsers
; settings. Optionally you can enable the language selection menu, which uses
; a session cookie to store the choice until the browser is closed.
languageselection = $PRIVATEBIN_LANGUAGE_SELECTION

EOF


if [ -n "$PRIVATEBIN_LANGUAGE_DEFAULT" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; set the language your installs defaults to, defaults to English
; if this is set and language selection is disabled, this will be the only language
languagedefault = "$PRIVATEBIN_LANGUAGE_DEFAULT"

EOF
fi


if [ -n "$PRIVATEBIN_QRCODE" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) Let users create a QR code for sharing the paste URL with one click.
; It works both when a new paste is created and when you view a paste.
qrcode = $PRIVATEBIN_QRCODE

EOF
fi


if [ -n "$PRIVATEBIN_ICON" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) IP based icons are a weak mechanism to detect if a comment was from
; a different user when the same username was used in a comment. It might get
; used to get the IP of a comment poster if the server salt is leaked and a
; SHA512 HMAC rainbow table is generated for all (relevant) IPs.
; Can be set to one these values:
; "none" / "identicon" (default) / "jdenticon" / "vizhash".
icon = "$PRIVATEBIN_ICON"

EOF
fi


if [ -n "$PRIVATEBIN_CSP_HEADER" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; Content Security Policy headers allow a website to restrict what sources are
; allowed to be accessed in its context. You need to change this if you added
; custom scripts from third-party domains to your templates, e.g. tracking
; scripts or run your site behind certain DDoS-protection services.
; Check the documentation at https://content-security-policy.com/
; Notes:
; - If you use a bootstrap theme, you can remove the allow-popups from the
;   sandbox restrictions.
; - By default this disallows to load images from third-party servers, e.g. when
;   they are embedded in pastes. If you wish to allow that, you can adjust the
;   policy here. See https://github.com/PrivateBin/PrivateBin/wiki/FAQ#why-does-not-it-load-embedded-images
;   for details.
; - The 'unsafe-eval' is used in two cases; to check if the browser supports
;   async functions and display an error if not and for Chrome to enable
;   webassembly support (used for zlib compression). You can remove it if Chrome
;   doesn't need to be supported and old browsers don't need to be warned.
cspheader = "$PRIVATEBIN_CSP_HEADER"

EOF
fi


if [ -n "$PRIVATEBIN_HTTP_WARNING" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; Enable or disable the warning message when the site is served over an insecure
; connection (insecure HTTP instead of HTTPS), defaults to true.
; Secure transport methods like Tor and I2P domains are automatically whitelisted.
; It is **strongly discouraged** to disable this.
; See https://github.com/PrivateBin/PrivateBin/wiki/FAQ#why-does-it-show-me-an-error-about-an-insecure-connection for more information.
httpwarning = $PRIVATEBIN_HTTP_WARNING

EOF
fi



#
# Expire section
#


PRIVATEBIN_EXPIRE_DEFAULT="${PRIVATEBIN_EXPIRE_DEFAULT:-1week}"
# shellcheck disable=SC2129
cat <<EOF >> /var/www/html/cfg/conf.php
[expire]
; expire value that is selected per default
; make sure the value exists in [expire_options]
default = "$PRIVATEBIN_EXPIRE_DEFAULT"

EOF



#
# Expire options section
#


cat <<EOF >> /var/www/html/cfg/conf.php
[expire_options]
; Set each one of these to the number of seconds in the expiration period,
; or 0 if it should never expire
5min = 300
10min = 600
1hour = 3600
1day = 86400
1week = 604800
; Well this is not *exactly* one month, it's 30 days:
1month = 2592000
; 1year = 31536000
; never = 0

EOF



#
# Formatter options section
#

cat <<EOF >> /var/www/html/cfg/conf.php
[formatter_options]
; Set available formatters, their order and their labels
plaintext = "Plain Text"
syntaxhighlighting = "Source Code"
markdown = "Markdown"

EOF



#
# Traffic section
#

PRIVATEBIN_TRAFFIC_LIMIT="${PRIVATEBIN_TRAFFIC_LIMIT:-10}"
cat <<EOF >> /var/www/html/cfg/conf.php
[traffic]
; time limit between calls from the same IP address in seconds
; Set this to 0 to disable rate limiting.
limit = $PRIVATEBIN_TRAFFIC_LIMIT

EOF


if [ -n "$PRIVATEBIN_TRAFFIC_EXEMPTED" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) Set IPs addresses (v4 or v6) or subnets (CIDR) which are exempted
; from the rate-limit. Invalid IPs will be ignored. If multiple values are to
; be exempted, the list needs to be comma separated. Leave unset to disable
; exemptions.
exempted = "$PRIVATEBIN_TRAFFIC_EXEMPTED"

EOF
fi


if [ -n "$PRIVATEBIN_TRAFFIC_CREATORS" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) If you want only some source IP addresses (v4 or v6) or subnets
; (CIDR) to be allowed to create pastes, set these here. Invalid IPs will be
; ignored. If multiple values are to be exempted, the list needs to be comma
; separated. Leave unset to allow anyone to create pastes.
creators = "$PRIVATEBIN_TRAFFIC_CREATORS"

EOF
fi


cat <<EOF >> /var/www/html/cfg/conf.php
; (optional) if your website runs behind a reverse proxy or load balancer,
; set the HTTP header containing the visitors IP address, i.e. X_FORWARDED_FOR
header = "X_FORWARDED_FOR"

EOF



#
# Purge section
#

PRIVATEBIN_PURGE_LIMIT="${PRIVATEBIN_PURGE_LIMIT:-300}"
cat <<EOF >> /var/www/html/cfg/conf.php
[purge]
; minimum time limit between two purgings of expired pastes, it is only
; triggered when pastes are created
; Set this to 0 to run a purge every time a paste is created.
limit = $PRIVATEBIN_PURGE_LIMIT

EOF


PRIVATEBIN_PURGE_BATCH_SIZE="${PRIVATEBIN_PURGE_BATCH_SIZE:-100}"
cat <<EOF >> /var/www/html/cfg/conf.php
; maximum amount of expired pastes to delete in one purge
; Set this to 0 to disable purging. Set it higher, if you are running a large
; site
batchsize = $PRIVATEBIN_PURGE_BATCH_SIZE

EOF



#
# Model section
#

PRIVATEBIN_MODEL_CLASS="${PRIVATEBIN_MODEL_CLASS:-Filesystem}"
cat <<EOF >> /var/www/html/cfg/conf.php
[model]
; name of data model class to load and directory for storage
; the default model "Filesystem" stores everything in the filesystem
; class = Database
class = $PRIVATEBIN_MODEL_CLASS

EOF

#
# Model options section
#

cat <<EOF >> /var/www/html/cfg/conf.php
[model_options]
EOF

PRIVATEBIN_MODEL_OPTIONS_CLASS="${PRIVATEBIN_MODEL_OPTIONS_CLASS:-Filesystem}"
if [ "$PRIVATEBIN_MODEL_OPTIONS_CLASS" = "Filesystem" ]; then
    PRIVATEBIN_MODEL_OPTIONS_DIR="${PRIVATEBIN_MODEL_OPTIONS_DIR:-/var/www/privatebin-data}"
    cat <<EOF >> /var/www/html/cfg/conf.php
dir = "$PRIVATEBIN_MODEL_OPTIONS_DIR"
EOF
    if [ ! -d "$PRIVATEBIN_MODEL_OPTIONS_DIR" ]; then
        fdc_error "PrivateBin data directory '$PRIVATEBIN_MODEL_OPTIONS_DIR' does not exist"
        false
    fi
    chown root:www-data "$PRIVATEBIN_MODEL_OPTIONS_DIR"
    chmod 0770 "$PRIVATEBIN_MODEL_OPTIONS_DIR"
fi

# Database support
if [ "$PRIVATEBIN_MODEL_OPTIONS_CLASS" = "Database" ]; then

    if [ "$PRIVATEBIN_MODEL_OPTIONS_DSN" ]; then
    cat <<EOF >> /var/www/html/cfg/conf.php
;dsn = "mysql:host=localhost;dbname=privatebin;charset=UTF8"
;dsn = "pgsql:host=localhost;dbname=privatebin"
;tbl = "privatebin_"	; table prefix
;usr = "privatebin"
;pwd = "Z3r0P4ss"
dsn = "$PRIVATEBIN_MODEL_OPTIONS_DSN"
opt[12] = true ; PDO::ATTR_PERSISTENT
EOF
    fi

    cat <<EOF >> /var/www/html/cfg/conf.php
tbl = "$PRIVATEBIN_MODEL_OPTIONS_TBL"
EOF

    PRIVATEBIN_MODEL_OPTIONS_USR="${PRIVATEBIN_MODEL_OPTIONS_USR:-privatebin}"
    cat <<EOF >> /var/www/html/cfg/conf.php
usr = "$PRIVATEBIN_MODEL_OPTIONS_USR"
EOF

    PRIVATEBIN_MODEL_OPTIONS_PWD="${PRIVATEBIN_MODEL_OPTIONS_PWD:-privatebin}"
    cat <<EOF >> /var/www/html/cfg/conf.php
pwd = "$PRIVATEBIN_MODEL_OPTIONS_PWD"
EOF

fi
