[![pipeline status](https://gitlab.conarx.tech/containers/privatebin/badges/main/pipeline.svg)](https://gitlab.conarx.tech/containers/privatebin/-/commits/main)

# Container Information

[Container Source](https://gitlab.conarx.tech/containers/privatebin) - [GitHub Mirror](https://github.com/AllWorldIT/containers-privatebin)

This is the Conarx Containers Nginx PHP PrivateBin image, it provides PrivateBin pastebin instance.

This PrivateBin-based image has support for termbin-like behavior when using Curl or Wget to POST content.



# Mirrors

|  Provider  |  Repository                                |
|------------|--------------------------------------------|
| DockerHub  | allworldit/privatebin                      |
| Conarx     | registry.conarx.tech/containers/privatebin |



# Conarx Containers

All our Docker images are part of our Conarx Containers product line. Images are generally based on Alpine Linux and track the
Alpine Linux major and minor version in the format of `vXX.YY`.

Images built from source track both the Alpine Linux major and minor versions in addition to the main software component being
built in the format of `vXX.YY-AA.BB`, where `AA.BB` is the main software component version.

Our images are built using our Flexible Docker Containers framework which includes the below features...

- Flexible container initialization and startup
- Integrated unit testing
- Advanced multi-service health checks
- Native IPv6 support for all containers
- Debugging options



# Community Support

Please use the project [Issue Tracker](https://gitlab.conarx.tech/containers/privatebin/-/issues).



# Commercial Support

Commercial support for all our Docker images is available from [Conarx](https://conarx.tech).

We also provide consulting services to create and maintain Docker images to meet your exact needs.



# Environment Variables

Additional environment variables are available from...
* [Conarx Containers Nginx PHP image](https://gitlab.conarx.tech/containers/nginx-php)
* [Conarx Containers Nginx image](https://gitlab.conarx.tech/containers/nginx)
* [Conarx Containers Postfix image](https://gitlab.conarx.tech/containers/postfix)
* [Conarx Containers Alpine image](https://gitlab.conarx.tech/containers/alpine)


## PRIVATEBIN_NAME

Set a project name to be displayed on the website. Defaults to "PrivateBin".


## PRIVATEBIN_BASEPATH

Set the full URL to the pastebin, required for images to display properly on social networks. eg. https://paste.example.com/pb/


## PRIVATEBIN_DISCUSSION

Enable or disable the discussion feature, defaults to "false".


## PRIVATEBIN_OPENDISCUSSION

Preselect the discussion feature, defaults to "false".


## PRIVATEBIN_PASSWORD

Enable or disable the password feature, defaults to "true".


## PRIVATEBIN_FILEUPLOAD

Enable or disable the file upload feature, defaults to "false".


## PRIVATEBIN_BURN_AFTER_READING_SELECTED

Preselect the burn-after-reading feature, defaults to "false".


## PRIVATEBIN_DEFAULT_FORMATTER

Specify which display mode to preselect by default, defaults to "plaintext".

Valued values are:
- plaintext
- syntaxhighlighting
- markdown


## PRIVATEBIN_SIZE_LIMIT

Set size limit per paste or comment in bytes, defaults to "10485760" (10MiB).


## PRIVATEBIN_TEMPLATE

Template to use, default is "bootstrap".


## PRIVATEBIN_INFO

Info text to display, defaults to "More information on the <a href='https://privatebin.info/'>project page</a>.".


## PRIVATEBIN_NOTICE

Notice to display, eg. "Note: This is a test service: Data may be deleted anytime. Kittens will die if you abuse this service."



## PRIVATEBIN_LANGUAGE_SELECTION

By default PrivateBin will guess the visitors language based on the browsers settings. Optionally you can enable the language
selection menu, which uses a session cookie to store the choice until the browser is closed. Defaults to "false".


## PRIVATEBIN_LANGUAGE_DEFAULT

Set the language your installs defaults to, defaults to "English".


## PRIVATEBIN_QRCODE

Let users create a QR code for sharing the paste URL with one click, defaults to "false".


## PRIVATEBIN_ICON

IP based icons are a weak mechanism to detect if a comment was from a different user when the same username was used in a comment.
It might get used to get the IP of a comment poster if the server salt is leaked and a SHA512 HMAC rainbow table is generated
for all (relevant) IPs.

Can be set to one these values:
- "none"
- "identicon" (default)
- "jdenticon"
- "vizhash".


## PRIVATEBIN_CSP_HEADER

Content Security Policy headers allow a website to restrict what sources are allowed to be accessed in its context.

eg. "default-src 'none'; base-uri 'self'; form-action 'none'; manifest-src 'self'; connect-src * blob:; script-src 'self' 'unsafe-eval'; style-src 'self'; font-src 'self'; frame-ancestors 'none'; img-src 'self' data: blob:; media-src blob:; object-src blob:; sandbox allow-same-origin allow-scripts allow-forms allow-popups allow-modals allow-downloads"


## PRIVATEBIN_HTTP_WARNING

Enable or disable the warning message when the site is served over an insecure connection (insecure HTTP instead of HTTPS),
defaults to "true".


## PRIVATEBIN_EXPIRE_DEFAULT

Expire value that is selected per default, defaults to "1week".

Valid values are:
- 5min
- 10min
- 1hour
- 1day
- 1week


## PRIVATEBIN_TRAFFIC_LIMIT

Time limit between calls from the same IP address in seconds

defaults to 10


## PRIVATEBIN_TRAFFIC_EXEMPTED

Set IPs addresses (v4 or v6) or subnets (CIDR) which are exempted from the rate-limit. Invalid IPs will be ignored.
If multiple values are to be exempted, the list needs to be comma separated. Leave unset to disable exemptions. eg.
"1.2.3.4,10.10.10/24"


## PRIVATEBIN_TRAFFIC_CREATORS

If you want only some source IP addresses (v4 or v6) or subnets (CIDR) to be allowed to create pastes, set these here.
Invalid IPs will be ignored. If multiple values are to be exempted, the list needs to be comma separated.
Leave unset to allow anyone to create pastes. eg. "1.2.3.4,10.10.10/24"


## PRIVATEBIN_PURGE_LIMIT

Minimum time limit between two purgings of expired pastes, it is only triggered when pastes are created. Set this to 0 to run
a purge every time a paste is created, defaults to "300".


## PRIVATEBIN_PURGE_BATCH_SIZE

Maximum amount of expired pastes to delete in one purge. Set this to 0 to disable purging. Set it higher, if you are running a large
site, defaults to "100".


## PRIVATEBIN_MODEL_CLASS

Name of data model class to load and directory for storage the default model "Filesystem" stores everything in the filesystem.

Valid values:
- Filesystem
- Database


## PRIVATEBIN_MODEL_OPTIONS_DIR

Applies to model class `Filesystem` and sets the data directory.


## PRIVATEBIN_MODEL_OPTIONS_DSN

Applies to model class `Database` and sets the database DSN.

Examples:
- "mysql:host=localhost;dbname=privatebin;charset=UTF8"
- "pgsql:host=localhost;dbname=privatebin"


## PRIVATEBIN_MODEL_OPTIONS_TBL

Applies to model class `Database` and sets the database DSN.

Set database talbe prefix.


## PRIVATEBIN_MODEL_OPTIONS_USR

Applies to model class `Database` and sets the database DSN.

Set database username, defaults to "privatebin".


## PRIVATEBIN_MODEL_OPTIONS_PWD

Applies to model class `Database` and sets the database DSN.

Set database password, defaults to "privatebin".



# Volumes


## /var/www/html

PrivateBin root.


## /var/www/privatebin-data

PrivateBin data directory, default path when the `Filesystem` model is used.



# Exposed Ports

Nginx port 80 is exposed by the [Conarx Containers Nginx image](https://gitlab.conarx.tech/containers/nginx) layer.



# Configuration

PHP configuration is done mostly in [Conarx Containers Nginx PHP image](https://gitlab.iitsp.com/allworldit/docker/nginx-php/README.md).

In addition to this configuration the below configuration is impleneted specifically for PrivateBin

| Path                                    | Description                      |
|-----------------------------------------|----------------------------------|
| /etc/php/conf.d/30-fdc-privatebin.ini   | PrivateBin PHP INI configuration |
| /etc/nginx/http.d/50_vhost_default.conf | Default PrivateBin Nginx config  |


Changes compared to [Conarx Containers Nginx PHP image](https://gitlab.iitsp.com/allworldit/docker/nginx-php/README.md)...

- `memory_limit` is set to `128M`


Default Nginx configuration...
```nginx
server {
	listen [::]:80 ipv6only=off;
	server_name localhost;

	root /var/www/html;
	index index.php;

	location = /favicon.ico {
		log_not_found off;
		access_log off;
	}

	location = /robots.txt {
		allow all;
		log_not_found off;
		access_log off;
	}

	location ~ ^\/(?:bin|cfg|i18n|lib|tpl|vendor)\/ {
		deny all;
	}

	location ~* \.(js|css|gif|ico|jpg|jpeg|png)$ {
		expires max;
	}

	# Check for user agent match for terminal tools
	set $tb "";
	if ($http_user_agent ~* "^(curl\/|Wget)") {
		set $tb ua;
	}
	# Check for method match
	if ($request_method = POST) {
		set $tb "${tb}method";
	}
	# Check both matched and trigger rewrite
	if ($tb = "uamethod") {
		rewrite ^/$ /termbin.php break;
	}

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ [^/]\.php(/|$) {
		# Mitigation against vulnerabilities in php-fpm, just incase
		fastcgi_split_path_info ^(.+?\.php)(/.*)$;

		# Make sure document exists
		if (!-f $document_root$fastcgi_script_name) {
			return 404;
		}

		# Mitigate https://httpoxy.org/ vulnerabilities
		fastcgi_param HTTP_PROXY "";

		# Pass request to php-fpm
		fastcgi_pass unix:/run/php-fpm.sock;
		fastcgi_index index.php;

		# Include fastcgi_params settings
		include fastcgi_params;

		# php-fpm requires the SCRIPT_FILENAME to be set
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

		fastcgi_param REDIRECT_STATUS 200;
	}
}
```



# Health Checks

Health checks are done by the underlying
[Conarx Containers Nginx PHP image](https://gitlab.iitsp.com/allworldit/docker/nginx-php/README.md).



# Example

```yaml
version: '3'

services:
  privatebin:
    image: registry.conarx.tech/containers/privatebin
	environment:
	  PRIVATEBIN_MODEL_OPTIONS_DSN: "mysql:host=localhost;dbname=privatebin;charset=UTF8"
	  PRIVATEBIN_MODEL_OPTIONS_USR: privatebin
	  PRIVATEBIN_MODEL_OPTIONS_PWD: privatebin
    ports:
      - '8080:80'
    volumes:
      # Web root
      - ./data/www:/var/www/html
      # NextCloud data
      - ./data/privatebin-data:/var/www/privatebin-data
      # Nginx config
      - ./config/nginx.conf:/etc/nginx/http.d/50_vhost_default.conf:ro
      # PHP ini customizations
      - ./config/php.ini:/etc/php8/conf.d/99-privatebin.ini
      # PHP fpm config
      - ./config/php-fpm-www.conf:/etc/php8/php-fpm.d/zzz-www-override.conf
    depends_on:
      - mariadb
    networks:
      - internal

  mariadb:
    image: registry.conarx.tech/containers/mariadb
    environment:
      MYSQL_DATABASE: 'privatebin'
      MYSQL_USER: 'privatebin'
      MYSQL_PASSWORD: 'privatebin'
      MYSQL_ROOT_PASSWORD: 'privatebin'
    volumes:
      # MariaDB data
      - ./data/mariadb:/var/lib/mysql
    networks:
      - internal
```
