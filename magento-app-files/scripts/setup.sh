#!/bin/bash

echo "[INFO] Starting Magento Setup...."

php $APP_HOME/bin/magento setup:install \
--admin-firstname=$MAG_ADMIN_FIRST_NAME \
--admin-lastname=$MAG_ADMIN_LAST_NAME \
--admin-email=$MAG_ADMIN_EMAIL \
--admin-user=$MAG_ADMIN_USERNAME \
--admin-password=$MAG_ADMIN_PASSWORD \
--base-url=$MAG_APP_BASE_URL \
--base-url-secure=$MAG_APP_BASE_URL \
--backend-frontname=$MAG_BACKEND_FRONTNAME \
--db-host=$DB_HOST \
--db-name=$DB_NAME \
--db-user=$DB_USER \
--db-password=$DB_PASSWORD \
--use-rewrites=1 \
--language=en_US \
--currency=USD \
--timezone=Asia/Dhaka \
--session-save=redis \
--session-save-redis-host=$SESSION_REDIS_HOST \
--session-save-redis-port=$SESSION_REDIS_PORT \
--session-save-redis-password=$SESSION_REDIS_PASSWORD \
--session-save-redis-persistent-id=$SESSION_REDIS_DB \
--cache-backend=redis \
--cache-backend-redis-server=$CACHE_REDIS_HOST \
--cache-backend-redis-port=$CACHE_REDIS_PORT \
--cache-backend-redis-db=$CACHE_REDIS_DB \
--cache-backend-redis-password=$CACHE_REDIS_PASSWORD \
--search-engine=elasticsearch7 \
--elasticsearch-host=$ELASTICSEARCH_HOST \
--elasticsearch-port=$ELASTICSEARCH_PORT \
--elasticsearch-enable-auth=1 \
--elasticsearch-username=$ELASTICSEARCH_USERNAME \
--elasticsearch-password=$ELASTICSEARCH_PASSWORD \
--disable-modules='Magento_TwoFactorAuth'

echo
echo
echo "[INFO] Setting deploy mode to Production ...."
php $APP_HOME/bin/magento deploy:mode:set production