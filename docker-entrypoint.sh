#!/bin/sh

# Environment Variable
MYSQL_HOST=${MYSQL_HOST:-mysql}
MYSQL_DATABASE=${MYSQL_DATABASE:-wordpress}
MYSQL_USER=${MYSQL_USER:-dowpe_user}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-dowpe_password}
MYSQL_PREFIX=""

# WordPress Variable
WP_VERSION=${WP_VERSION:-latest}
WP_LOCALE=${WP_LOCALE:-en_US}
WP_THEME=${WP_THEME:-twentyseventeen}
WP_URL=${WP_URL:-localhost\:8080}
WP_TITLE=${WP_TITLE:-Dowpe-WordPress}
WP_ADMIN=${WP_ADMIN:admin}
WP_PASSWORD=${WP_PASSWORD:-password}
WP_EMAIL=${WP_EMAIL:-admin\@localhost}

# Color Collections
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

success() {
  echo -e ${GREEN}${BOLD}$1${NC}
}

error() {
  echo -e ${RED}$1${NC}
}

info() {
  echo -e ${CYAN}$1${NC}
}


# TODO
# install theme and remove others
# install plugins

wp_download() {
  wp --allow-root core download --version=$WP_VERSION --locale=$WP_LOCALE
}

wp_create_config() {
  wp --allow-root config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --dbprefix=${MYSQL_PREFIX}
}

wp_install() {
    wp --allow-root core install
}

main() {
  if ! $(wp --allow-root core is-installed); then
    info 'Start WordPress Installation'
    wp_download

    until nc -z -v -w30 $MYSQL_HOST 3306
    do
      info "Waiting for database connection..."
      sleep 5
    done

    success 'Database established!'

    # Check exists wp-config.php
    wp --allow-root config path
    isConfig=$?

    if [ $isConfig -ne 1 ]; then
      info 'Generating wp-config.php'
      wp_create_config
    fi

    wp --allow-root config path

    # wp_install
  fi
}

main
