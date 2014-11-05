#!/bin/bash

# Load the variables from the ENV
VERSION=$VERSION

DB_USER=$DB_USER
DB_PASS=$DB_PASS
DB_NAME=$DB_NAME
DB_HOST=$DB_HOST

WORKDIR=$WORKDIR
RUN_USER=$RUN_USER

DRUPAL_PKG="/tmp/drupal-$VERSION.tar.gz"

echo -n "Fetch the drupal package from drupal.org... " >&2
if [ ! -f "$DRUPAL_PKG" ]; then
    wget http://ftp.drupal.org/files/projects/drupal-$VERSION.tar.gz -O "$DRUPAL_PKG"
    echo "[Done]" >&2
else
    echo "[Already present]" >&2
fi

echo -n "Unpacking Drupal... " >&2
cd "$WORKDIR"
tar --strip-components=1 -xzvf "$DRUPAL_PKG"
if [ $? -ne 0 ]; then
    echo "[Error]" >&2
    echo "Check the logs" >&2
    exit 1
else
    echo "[Success]"
fi

echo "Preparing Drupal configuration... " >&2
cd $WORKDIR
if [ ! -e sites/default/settings.php ]; then
    cp sites/default/default.settings.php sites/default/settings.php
    cat >> sites/default/settings.php << EOF

/**
 * devo.ps database setup
 */

\$databases['default']['default'] = array(
    'driver' => 'mysql',
    'database' => '$DB_NAME',
    'username' => '$DB_USER',
    'password' => '$DB_PASS',
    'host' => '$DB_HOST',
    'collation' => 'utf8_general_ci',
);

EOF

    sudo chmod 664 sites/default/settings.php
    sudo chown -R $RUN_USER:$RUN_USER sites/default/settings.php

else
    echo "The settings.php file is already present - skipping." >&2
fi

echo "Setting permissions for the files folders" >&2
for folder in sites/default/files sites/default/private sites/default/private/files
do
    sudo mkdir -p $folder
    sudo chmod 775 $folder
    sudo chown -R $RUN_USER:$RUN_USER $folder
done
