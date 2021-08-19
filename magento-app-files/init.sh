#!/bin/bash
set -e
echo '[INFO] Staring init script....';
sleep 1s

files=(/home/klovercloud/app/*)
if [ ${#files[@]} -lt 10 ]; then 
    echo "[INFO] Copying all app files to $APP_HOME";
	cp -r $TEMP_APP_HOME/. $APP_HOME/.
    echo "[INFO] All app files copied to $APP_HOME";
else
	echo "[INFO] $APP_HOME is not empty. Updating only /app /var & /pub directory with latest code";
    cp $TEMP_APP_HOME/*.* $APP_HOME/.
    cp -r $TEMP_APP_HOME/app/. $APP_HOME/app/.
    cp -r $TEMP_APP_HOME/var/. $APP_HOME/var/.
    cp -r $TEMP_APP_HOME/pub/. $APP_HOME/pub/.

    echo "[INFO] Code updated";

    mkdir -p $APP_HOME/scripts
    cp -r $TEMP_APP_HOME/bin/. $APP_HOME/bin/. &
    cp -r $TEMP_APP_HOME/lib/. $APP_HOME/lib/. &
    cp -r $TEMP_APP_HOME/phpserver/. $APP_HOME/phpserver/. &
    cp -r $TEMP_APP_HOME/scripts/. $APP_HOME/scripts/. &
    cp -r $TEMP_APP_HOME/setup/. $APP_HOME/setup/. &
fi

echo "[INFO] Checking if magento has been installed or not.";

CONFIG_FILE=$APP_HOME/app/etc/config.php
ENV_FILE=$APP_HOME/app/etc/env.php

if [ -f "$CONFIG_FILE" ] && [ -f "$ENV_FILE" ]; then
    echo
    echo
    echo "[INFO] $CONFIG_FILE & $ENV_FILE already exists. No need to setup magento."
    bash $APP_HOME/scripts/compile.sh
fi

echo
echo
echo "[INFO] Initialization completed.";
