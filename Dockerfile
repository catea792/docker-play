FROM php:8.1-fpm

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www

COPY . .

RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install

EXPOSE 9000
CMD ["php-fpm"]