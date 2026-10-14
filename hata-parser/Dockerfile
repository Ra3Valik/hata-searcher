# Базовый образ с PHP 8.4 и Alpine Linux
FROM php:8.4-cli-alpine

# Папка в контейнере, в которой будет находиться проект и выполняться команды
WORKDIR /app

# Метаданные об авторе контейнера
LABEL authors="Ra3Valik"

# Системная библиотека для работы с PostgreSQL и RabbitMQ
RUN apk add --no-cache postgresql-dev libpq-dev rabbitmq-c-dev autoconf build-base

# Установка расширений PHP
RUN docker-php-ext-install pdo pdo_pgsql

# Установка расширения AMQP для работы с RabbitMQ
RUN pecl install amqp \
    && docker-php-ext-enable amqp

# Копируем только файлы, при которых нам надо пересобирать контейнер при изменении зависимостей
COPY composer.json composer.lock ./
# Установка Composer и пакетов проекта без dev-зависимостей и с оптимизацией автозагрузки
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
RUN composer install --optimize-autoloader --no-cache --no-scripts

# Копируем весь проект в контейнер (в дев среде необязательно из-за mount volume)
COPY . .

# Команда которая будет выполняться при запуске контейнера
# последний параметр -v отвечает за логи
# -v Notice+
# -vv - INFO+
# -vvv - DEBUG+
ENTRYPOINT ["php", "bin/console", "messenger:consume", "scheduler_default", "-vvv"]