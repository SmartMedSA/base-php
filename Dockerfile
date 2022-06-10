FROM php:8.0.19-cli

SHELL ["/bin/bash", "-c"]

ENV APP_ROOT="/var/www/app"

RUN set -xe; \
    \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    g++ \
    git \
    libicu-dev \
    libonig-dev \
    libpng-dev \
    librabbitmq-dev \
    libssh-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    locales \
    sudo \
    wait-for-it \
    zlib1g-dev; \
    \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen; \
    \
    # Add templating tool.
    gotpl_url="https://github.com/wodby/gotpl/releases/download/0.3.3/gotpl-linux-amd64.tar.gz"; \
    curl -sL "${gotpl_url}" | tar xz --no-same-owner -C /usr/local/bin; \
    \
    docker-php-ext-install \
    bcmath \
    calendar \
    dom \
    gd \
    gd \
    intl \
    mbstring \
    opcache \
    pcntl \
    pcntl \
    pdo \
    pdo_mysql \
    sockets \
    xsl \
    zip \
    zip; \
    \
    pecl install \
    amqp-1.11.0beta \
    apcu \
    redis-5.3.4 \
    xdebug; \
    \
    docker-php-ext-enable \
    amqp \
    apcu \
    redis \
    xdebug; \
    \
    docker-php-ext-configure \
    intl;

# Create a group and user.
RUN set -xe; \
    \
    install -o www-data -g www-data -d \
        "${APP_ROOT}"; \
    chown -R www-data:www-data \
        "${PHP_INI_DIR}/conf.d";   \
    mkdir -p /etc/sudoers.d; \
     { \
         echo 'Defaults env_keep += "APP_ROOT FILES_DIR" ' ; \
         echo 'www-data ALL=NOPASSWD: /usr/local/bin/init_container ' ; \
     } | tee /etc/sudoers.d/www-data;

# Add latest composer version.
COPY --from=composer:2.3 /usr/bin/composer /usr/local/bin/composer
# Add RoadRunner.
COPY --from=spiralscout/roadrunner:2.6.4 /usr/bin/rr /usr/bin/rr

WORKDIR "${APP_ROOT}"
USER www-data

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY docker/php/templates /etc/gotpl
COPY docker/php/docker-entrypoint.sh /
COPY docker/php/bin /usr/local/bin/
COPY docker/php/docker-entrypoint-init.d/ /docker-entrypoint-init.d/
