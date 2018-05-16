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

# Color Collection
NORMAL=$(tput sgr0)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2; tput bold)
RED=$(tput setaf 1)

function error() {
  echo -e "$RED$*$NORMAL"
}

function success() {
  echo -e "$GREEN$*$NORMAL"
}

function warn() {
  echo -e "$YELLOW$*$NORMAL"
}

function info() {
  echo -e "$CYAN$*$NORMAL"
}

# wp --allow-root core download

# TODO
# Download wp core with param
# Wait for db, then set up wp-config.php with param
# install theme and remove others
# install plugins



main() {

  #until nc -z -v -w30 $DB_HOST 3306
  #do
    #echo "Waiting for database connection..."
    # wait for 5 seconds before check again
    #sleep 5
  #done

  echo 'test'
  echo $DB_HOST

  #if [ -z "" ]; then
  #  error 'Error! Can not complete to install WordPress'
  #  exit 1
  #fi
}

main
