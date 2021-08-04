# Installing and Running Magento in KloverCloud
###

#### Step 1 - Local Setup
- Download magento in your local machine 
- Copy the all files from `/magneto-app-files` directory in the root directory of your magento project. Put your public & private keys in the auth.json file. You can generate the key from https://marketplace.magento.com/customer/accessKeys/
- Push your magento project to your git repository

###
#### Step 2 - Setup Database, Cache & Elasticsearch
- Create a MySQL database server in KloverCloud
- Create a database for magento
- Create a Redis Server in KloverCloud
- Create a Elasticsearch Server. Instructions given here (https://github.com/klovercloud/elasticsearch-dev-example).

###
#### Step 3 - Onboarding & Running in KloverCloud
- On board your magento application though git in klovercloud
- Select PHP as language
- Select atleast 4 vCPU & 8GB RAM
- Select atleast 10GB Persistent Volume (Mount Paths: `/home/klovercloud/vol/app/etc;/home/klovercloud/vol/pub/media`)
- Select atleast 4GB In-Memory Volume (Non-Persistent) (Mount Path: `/home/klovercloud/app`)
- Create application
- Build
- Import required Environment Variables & Secrets for the application in KloverCloud for auto magento installation on first deployment. Sample yaml files are given under `/kcp` directory. Edit them with your values before importing them in KloverCloud.
- Deploy
- Enjoy

###
#### Step 4 - Terminal Access
- Access the Terminal of the deployed instance though KloverCloud Console (Application -> Overview -> Access Terminal)


####
##### Installation Completed. Try to access your magento app now through browser.

###
#### Cheat Sheet
###
- Install Magento
```
php bin/magento setup:install \
--admin-firstname=Magento \
--admin-lastname=Admin \
--admin-email=admin.magento@gmail.com \
--admin-user=admin \
--admin-password='SomePassword123' \
--base-url=https://YOUR_DOMAIN \
--base-url-secure=https://YOUR_DOMAIN \
--backend-frontname=admin \
--db-host=YOUR_MYSQL_ENDPOINT \
--db-name=YOUR_DB_NAME \
--db-user=YOUR_MYSQL_USERNAME \
--db-password=YOUR_MYSQL_PASSWORD \
--use-rewrites=1 \
--language=en_US \
--currency=USD \
--session-save=redis \
--session-save-redis-host=YOUR_REDIS_HOST \
--session-save-redis-port=YOUR_REDIS_PORT \
--session-save-redis-password=YOUR_REDIS_PASSWORD \
--session-save-redis-persistent-id=YOUR_REDIS_DB_FOR_SESSION \
--cache-backend=redis \
--cache-backend-redis-server=YOUR_REDIS_HOST \
--cache-backend-redis-port=YOUR_REDIS_PORT \
--cache-backend-redis-db=YOUR_REDIS_DB_FOR_CACHE \
--cache-backend-redis-password=YOUR_REDIS_PASSWORD \
--search-engine=elasticsearch7 \
--elasticsearch-host=YOUR_ELASTIC_SEARCH_ENDPOINT \
--elasticsearch-port=YOUR_ELASTIC_SEARCH_PORT \
--elasticsearch-enable-auth=1 \
--elasticsearch-username=YOUR_ELASTIC_SEARCH_USERNAME \
--elasticsearch-password=YOUR_ELASTIC_SEARCH_PASSWORD \
--use-sample-data \
--disable-modules='Magento_TwoFactorAuth' // if avoiding 2fa while installation. You can also add 'Magento_Elasticsearch,Magento_Elasticsearch6,Magento_Elasticsearch7' here to skip elasticsearch 
```

- Run Index Cron
```
bin/magento cron:run --group index
```

- Turn off Elastic Search if requires
```
php bin/magento module:disable Magento_Elasticsearch Magento_Elasticsearch6 Magento_Elasticsearch7
```

- Turn off Two Factor Auth (2FA) if requires
```
php bin/magento module:disable Magento_TwoFactorAuth
```

- Change Base Url through CLI
```
php bin/magento setup:store-config:set --base-url="http://yourdomain.com"
php bin/magento setup:store-config:set --base-url-secure="https://yourdomain.com"
php bin/magento cache:flush
```

- Compile
```
php bin/magento setup:di:compile
```

- Deploy all statics (if required)
```
php bin/magento setup:static-content:deploy -f
```

- Enable Developer Mode
```
php bin/magento deploy:mode:set developer
```

- Enable Production Mode
```
php bin/magento deploy:mode:set production
```

#### Enjoy
