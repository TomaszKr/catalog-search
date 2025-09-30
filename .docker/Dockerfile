FROM php:8.4-fpm

# Define build arguments
ARG USER_ID
ARG GROUP_ID

# Define environment variables
ENV USER_ID=$USER_ID
ENV GROUP_ID=$GROUP_ID
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}

# Add group and user based on build arguments
RUN addgroup --gid ${GROUP_ID} customUser
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} customUser

# Set user and group of working directory
RUN chown -R www-data:www-data /var/www/html

RUN apt-get update && apt-get install -y     git zip unzip curl libpq-dev libonig-dev libzip-dev libxml2-dev libjpeg-dev libpng-dev libfreetype6-dev     && docker-php-ext-install pdo pdo_pgsql zip opcache     && docker-php-ext-configure gd --with-freetype --with-jpeg     && docker-php-ext-install gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

USER customUser
WORKDIR /var/www/html
