FROM spiralscout/roadrunner:2.6.4 as rr

FROM php:8.0.14-cli

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV APP_ROOT="/var/www"

RUN set -xe; \
    \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    locales \
    apt-utils \
    git \
    libicu-dev \
    g++ \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    libxslt-dev \
    librabbitmq-dev \
    zlib1g-dev \
    libssh-dev ; \
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
    pdo \
    pdo_mysql \
    gd \
    opcache \
    intl \
    zip \
    calendar \
    dom \
    pcntl \
    mbstring \
    zip \
    gd \
    xsl \
    bcmath \
    sockets; \
    \
    pecl install \
    apcu \
    xdebug \
    redis-5.3.4 \
    amqp-1.11.0beta; \
    \
    docker-php-ext-enable \
    redis \
    apcu \
    xdebug \
    amqp; \
    \
    docker-php-ext-configure intl;

# Copy RoadRunner
COPY --from=rr /usr/bin/rr /usr/bin/rr

WORKDIR ${APP_ROOT}

COPY docker/php/templates /etc/gotpl
COPY docker/php/docker-entrypoint.sh /
COPY docker/php/bin /usr/local/bin/
COPY docker/php/docker-entrypoint-init.d/ /docker-entrypoint-init.d/

ENTRYPOINT ["/docker-entrypoint.sh"]
