# Dowpe - PHP


[![MicroBadger Size](https://img.shields.io/microbadger/image-size/nismit/dowpe-php.svg)](https://microbadger.com/images/nismit/dowpe-php)&nbsp; [![MicroBadger Layers](https://img.shields.io/microbadger/layers/nismit/dowpe-php.svg)](https://microbadger.com/images/nismit/dowpe-php)&nbsp; [![Docker Pulls](https://img.shields.io/docker/pulls/nismit/dowpe-php.svg)](https://hub.docker.com/r/nismit/dowpe-php/)&nbsp; ![Docker Automated build](https://img.shields.io/docker/automated/nismit/dowpe-php.svg)&nbsp; ![license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)


Docker WordPress Environment PHP Container

## PHP Version
Using `php:fpm-alpine` from Official Repository. Docker always will pull latest image which tags `fpm-alpine`.
See [PHP - Docker Hub](https://hub.docker.com/_/php/)

## Customized php.ini
Original `php.ini` from [php-src](https://github.com/php/php-src)


```
expose_php = Off
max_execution_time = 60
post_max_size = 10M
upload_max_filesize = 10M
opcache.enable_cli=1
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=2

session.save_handler = memcached
session.save_path = memcached:11211
```

## Installed PHP Modules
Dowpe-php is installed php modules in addition for WordPress.

```
gd (available to font, jpeg, png, webp)
soap
mysqli
image magick
memcached
opcache
```

The full list of installed modules

```
$ php -m
[PHP Modules]
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
hash
iconv
imagick
json
libxml
mbstring
memcached
mysqli
mysqlnd
openssl
pcre
PDO
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
soap
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
Zend OPcache
zlib

[Zend Modules]
Zend OPcache
```
