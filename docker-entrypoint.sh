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
WP_PLUGINS=${WP_PLUGINS:-wp-multibyte-patch\ duplicate-post}
WP_URL=${WP_URL:-localhost\:8080}
WP_TITLE=${WP_TITLE:-Dowpe-WordPress}
WP_ADMIN=${WP_ADMIN:admin}
WP_PASSWORD=${WP_PASSWORD:-password}
WP_EMAIL=${WP_EMAIL:-example\@example.com}

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

wp_download() {
  wp --allow-root core download --version=$WP_VERSION --locale=$WP_LOCALE
}

wp_create_config() {
  wp --allow-root config path --quiet

  if [ $? -eq 1 ]; then
    info 'Not found wp-config.php'
    info 'Generating wp-config.php'
    wp --allow-root config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --dbprefix=${MYSQL_PREFIX} --color
  fi

  info 'wp-config.php path: '
  wp --allow-root config path
}

wp_install() {
    wp --allow-root core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_PASSWORD} --admin_email=${WP_EMAIL} --color

    if [ $? -eq 1 ]; then
      error 'Failed WordPress Install'
      exit 1
    fi
}

wp_install_plugins() {
  wp --allow-root plugin install ${WP_PLUGINS} --activate --color
}

wp_clean_up_plugins() {
  wp --allow-root plugin delete $(wp --allow-root plugin list --status=inactive --field=name) --color
}

wp_clean_up_themes() {
  wp --allow-root theme delete $(wp --allow-root theme list --status=inactive --field=name) --color
}

main() {
  until nc -z -v -w30 $MYSQL_HOST 3306
  do
    info "Waiting for database connection..."
    info "If mysql container is not running, press Ctrl+C to shutdown this script."
    sleep 5
  done

  success 'Database connection established!'

  if ! $(wp --allow-root core is-installed); then
    info 'Start WordPress Installation'

    # Check WordPress Core files
    wp_download

    # Check exists wp-config.php
    wp_create_config

    # Install WordPress
    wp_install

    # Clean up plugins which are inactive
    wp_clean_up_plugins

    # Install listed plugins
    wp_install_plugins

    # Clean up themes which are inactive
    # Because of security risk that having old theme
    wp_clean_up_themes

    exit 0
  fi

  success 'WordPress has been installed!'
  exit 0
}

main
