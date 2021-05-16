# Installing and Running Magento in KloverCloud
###

#### Step 1 - Local Setup
- Download magento in your local machine 
- Copy the all files from app-files dir in the root directory of your magento project. Put your public & private keys in the auth.json file. You can generate the key from https://marketplace.magento.com/customer/accessKeys/
- Push your magento project to github / bitbucket / gitlab

###
#### Step 2 - Onboarding in KloverCloud
- On board your magento application though git in klovercloud
- Select PHP as language and LARAVEL as the framework
- Select atleast 4 vCPU & 8GB RAM
- Select atleast 10GB Persistent Volume (Mount directory: /home/klovercloud/app)
- Create application, Build & Deploy


###
#### Step 3 - Database
- Create a MySQL database server in KloverCloud
- Create a database for magento

###
#### Step 4 - Magento Installation
- Access the Terminal of the deployed instance though KloverCloud Console (Application -> Overview -> Access Terminal)
- Run the following command to install magento
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
--timezone=Asia/Dhaka \
--session-save=files \
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

####
##### Installation Completed. Try to access your magento app now through browser.

###
#### Cheat Sheet
###
- Turn off Elastic Search if requires
```
php bin/magento module:disable Magento_Elasticsearch Magento_Elasticsearch6 Magento_Elasticsearch7
```

- Turn off Two Factor Auth (2FA) if requires
```
php bin/magento module:disable Magento_TwoFactorAuth
```

- Deploy all statics (if required)
```
php bin/magento setup:static-content:deploy -f
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

- Enable Developer Mode
```
php bin/magento deploy:mode:set developer
```

#### Enjoy
