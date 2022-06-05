FROM spiralscout/roadrunner:2.6.4 as rr

FROM php:8.0.19-cli

SHELL ["/bin/bash", "-c"]

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
    sudo \
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
    pcntl \
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

# Create a group and user.
RUN groupadd --gid 2000 www-data && useradd --shell /bin/bash --gid 2000 --uid 2000 www-data; \
    install -o www-data -g www-data -d \
        "${APP_ROOT}"; \
    chown -R www-data:www-data \
        "${PHP_INI_DIR}/conf.d";   \
    mkdir -p /etc/sudoers.d; \
     { \
         echo 'Defaults env_keep += "APP_ROOT FILES_DIR" ' ; \
         echo 'www-data ALL=NOPASSWD: /usr/local/bin/init_container ' ; \
     } | tee /etc/sudoers.d/www-data;

# Copy RoadRunner.
COPY --from=rr /usr/bin/rr /usr/bin/rr

ENTRYPOINT ["/docker-entrypoint.sh"]
USER www-data
WORKDIR ${APP_ROOT}

COPY docker/php/templates /etc/gotpl
COPY docker/php/docker-entrypoint.sh /
COPY docker/php/bin /usr/local/bin/
COPY docker/php/docker-entrypoint-init.d/ /docker-entrypoint-init.d/
