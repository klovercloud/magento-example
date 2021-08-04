#!/bin/bash

if [ "$MAG_COMPILE_ON_INIT" = 'true' ]; then
    echo
    echo
    echo "[INFO] Starting Magento Compile ...."
    php $APP_HOME/bin/magento setup:di:compile

    echo
    echo
    echo "[INFO] Starting Magento Static Content Deploy ...."
    php $APP_HOME/bin/magento setup:static-content:deploy -f
fi