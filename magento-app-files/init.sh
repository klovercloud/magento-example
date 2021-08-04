#!/bin/bash
set -e
echo '[INFO] Staring init script....';
sleep 1s

export APP_ETC_VOLUME_MOUNT_PATH="/home/klovercloud/vol/app/etc"
export MEDIA_VOLUME_MOUNT_PATH="/home/klovercloud/vol/pub/media"

echo "[INFO] Removing existing symbolic links before copying all app files from temp dir";
if [ -d "$APP_HOME/app/etc" ]; then
    echo "[INFO] Removing symbolic link for $APP_HOME/app/etc";
    unlink $APP_HOME/app/etc
    rm -rf $APP_HOME/app/etc
fi

if [ -d "$APP_HOME/pub/media" ]; then
    echo "[INFO] Removing symbolic link for $APP_HOME/pub/media";
    unlink $APP_HOME/pub/media
    rm -rf $APP_HOME/pub/media
fi

echo "[INFO] Copying app files to $APP_HOME from temp dir";
cp -r $TEMP_APP_HOME/. $APP_HOME/.
echo "[INFO] All app files copied to $APP_HOME";

sleep 1s

# Creating symbolic link for pub/media so that all files under it will be stored in a persistent volume.
echo '[INFO] Creating symbolic link for pub/media';
# removing the directory for symobilc link creation
rm -rf $APP_HOME/pub/media
ln -s $MEDIA_VOLUME_MOUNT_PATH $APP_HOME/pub/media
cp -r $TEMP_APP_HOME/pub/media/. $APP_HOME/pub/media/.

echo '[INFO] Creating symbolic link for app/etc';
# removing the directory for symobilc link creation
rm -rf $APP_HOME/app/etc
ln -s $APP_ETC_VOLUME_MOUNT_PATH $APP_HOME/app/etc
cp -r $TEMP_APP_HOME/app/etc/. $APP_HOME/app/etc/.


CONFIG_FILE=$APP_HOME/app/etc/config.php
ENV_FILE=$APP_HOME/app/etc/env.php

if [ -f "$CONFIG_FILE" ] && [ -f "$ENV_FILE" ]; then
    echo
    echo
    echo "[INFO] $CONFIG_FILE & $ENV_FILE already exists. No need to setup magento."
    bash $APP_HOME/scripts/compile.sh
else
    echo
    echo
    echo "[WARN] $CONFIG_FILE & $ENV_FILE does not exists."
    bash $APP_HOME/scripts/setup.sh
fi

echo
echo
echo "[INFO] Starting Magento Index Cron ...."
php bin/magento cron:run --group index

echo
echo
echo '[INFO] Initialization Completed';
echo
echo
