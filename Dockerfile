FROM php:5.6-fpm

RUN apt-get -qq update && apt-get -qq install libxml++2.6-dev > /dev/null
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev\     
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mbstring mysql mysqli pdo pdo_mysql soap
    

RUN apt-get install -y libmcrypt-dev 
# RUN yes | pecl install xdebug
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install pdo pdo_mysql
RUN apt-get install -y libicu-dev 

RUN apt-get update && apt-get install -q -y ssmtp mailutils && rm -rf /var/lib/apt/lists/*

RUN chmod -R 777 /var/www /var/www/.* \
  && chown -R www-data:www-data /var/www /var/www/.* \
  && usermod -u 1000 www-data \
  && chsh -s /bin/bash www-data
