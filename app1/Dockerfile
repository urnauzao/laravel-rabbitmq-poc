# VARIAVEIS DE BUILD
ARG NODE_VERSION
ARG PHP_VERSION
ARG NODE_ENV
ARG APP_URL

## STAGE 1: Node.js para a compilação dos arquivos estáticos
FROM node:${NODE_VERSION} as builder

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o package.json e o package-lock.json (se existir) para instalar as dependências
COPY package*.json ./

# Instalar as dependências
RUN npm i

# Copiar os arquivos da aplicação para o diretório de trabalho
COPY . .

# Compilar os arquivos estáticos
RUN npm run build

## STAGE 2: PHP Server
FROM php:${PHP_VERSION} as server

### Diretório da aplicação
ARG APP_DIR=/var/www/app
ARG EXTERNAL_APP_DIR=./../../

### Versão da Lib do Redis para PHP
ARG REDIS_LIB_VERSION=5.3.7

### Instalação de pacotes e recursos necessários no S.O.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    supervisor \
    zlib1g-dev \
    libzip-dev \
    unzip \
    libpng-dev \
    libpq-dev \
    libxml2-dev \
    nginx \
    cron \
    librabbitmq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Dependências recomendadas do PHP
RUN docker-php-ext-install pdo pdo_pgsql pgsql session xml zip iconv simplexml pcntl gd fileinfo sockets \
    && pecl install redis-${REDIS_LIB_VERSION} \
    && docker-php-ext-enable redis \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
    && pecl install amqp \
    && docker-php-ext-enable amqp

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# ### NGINX
RUN rm -rf /etc/nginx/sites-enabled/* \
    && rm -rf /etc/nginx/sites-available/*

### Arquivos de configuração
COPY --chown=www-data:www-data ./docker/supervisord/supervisord.octane.conf /etc/supervisor/conf.d/supervisord.conf
# COPY --chown=www-data:www-data ./docker/supervisord/conf /etc/supervisord.d/
COPY --chown=www-data:www-data ./docker/php/extra-php.ini "$PHP_INI_DIR/conf.d/99_extra.ini"
COPY --chown=www-data:www-data ./docker/nginx/sites.octane.conf /etc/nginx/sites-enabled/default.conf
COPY --chown=www-data:www-data ./docker/nginx/error.html /var/www/app/error.html


### Copiando aplicação para dentro do container
WORKDIR $APP_DIR
COPY --chown=www-data:www-data . .
RUN cd $APP_DIR

## NODE
RUN rm -rf node_modules public/build public/hot vendor composer.lock
COPY --chown=www-data:www-data --from=builder /app/public/build /var/www/app/public/build

### OCTANE
RUN chown -R www-data:www-data $APP_DIR \
    && composer install --no-interaction --no-dev

### HORIZON
# RUN composer require laravel/horizon \
#     && php artisan horizon:install

### Comandos úteis para otimização da aplicação
RUN php artisan clear-compiled \
    && rm -rf .env \
    && php artisan optimize:clear

COPY ./docker/cron/script_schedule_run /etc/cron.d/script_schedule_run
# RUN chmod +x /etc/cron.d/script_schedule_run
RUN chmod 0644 /etc/cron.d/*
RUN crontab /etc/cron.d/script_schedule_run

### Limpeza e otimização da construção
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && apt-get clean

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
