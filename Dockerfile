FROM php:7.1-fpm

RUN apt-get update

# install the PHP extensions we need
RUN apt-get install -y \
    libpng12-dev libfreetype6-dev libjpeg62-turbo-dev  \
    libjpeg-dev libpq-dev zip unzip wget git imagemagick \
    zlib1g-dev libicu-dev g++ libmagickwand-dev

#install extensions
RUN docker-php-ext-install mysqli gd pdo_mysql pdo_pgsql intl

#install pecl extensions
RUN pecl install imagick

#enable imagick
RUN docker-php-ext-enable imagick imagick.so

#enable gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/


#extend php config
ADD php_extend_config.ini /usr/local/etc/php/conf.d/php_extend_config.ini

#install composer and hirak/prestissimo
ADD composer_installer.sh /temp/composer_installer.sh
RUN /temp/composer_installer.sh

#OMG install mysql 0_0
RUN DEBIAN_FRONTEND=noninteractive apt-get -y -f -q install mysql-server

RUN service mysql start