#!/bin/sh

# Environment Variable
DB_HOST=${DB_HOST:-mysql}
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-root}
DB_PASS=${DB_PASS:-password}
DB_PREFIX=${DB_PREFIX:-wp_}
# WordPress Variable
WP_VERSION=${WP_VERSION:-latest}
WP_LOCALE=${WP_LOCALE:-en_US}
WP_THEME=${WP_THEME:-twentyseventeen}

# wp --allow-root core download

# TODO
# Download wp core with param
# Wait for db, then set up wp-config.php with param
# install theme and remove others
# install plugins

main() {
  echo 'test'
  echo $DB_HOST
}

main
