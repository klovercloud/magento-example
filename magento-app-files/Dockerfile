FROM klovercloud/php-7.4-apache2-magento-base-image:v1.0.1

WORKDIR $TEMP_APP_HOME

COPY . .

RUN chown -R klovercloud:klovercloud $TEMP_APP_HOME
RUN chown -R klovercloud:klovercloud $APP_HOME

#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer --version=2.1.4

# install all PHP dependencies
RUN composer install --no-interaction

COPY php.ini /usr/local/etc/php/php.ini

RUN chmod +x init.sh
RUN sed -i 's/\r$//' init.sh

RUN chmod +x scripts/*
RUN sed -i 's/\r$//' scripts/*

#For Apache Log Aggregation
RUN sed -i -r 's@ErrorLog .*@ErrorLog /dev/stderr@i' /etc/apache2/apache2.conf
RUN echo "TransferLog /dev/stdout" >> /etc/apache2/apache2.conf
RUN echo "CustomLog /dev/stdout combined" >> /etc/apache2/apache2.conf
RUN sed -i -r 's@ErrorLog .*@ErrorLog /dev/stderr@i' /etc/apache2/sites-available/000-default.conf
RUN sed -i -r 's@CustomLog .*@CustomLog /dev/stdout combined@i' /etc/apache2/sites-available/000-default.conf
RUN sed -i -r 's@ErrorLog .*@ErrorLog /dev/stderr@i' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i -r 's@CustomLog .*@CustomLog /dev/stdout combined@i' /etc/apache2/sites-enabled/000-default.conf

EXPOSE 8080
WORKDIR $APP_HOME
USER klovercloud