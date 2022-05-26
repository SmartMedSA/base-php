FROM registry.gitlab.com/new-med/base-php:latest

COPY composer.json composer.lock ${APP_ROOT}/

RUN set -xe; \
    composer validate --no-interaction --quiet;\
    composer install --no-dev --no-scripts --no-plugins --prefer-dist --no-progress --no-interaction

CMD ["rr", "serve", "-c", ".rr.yaml"]
