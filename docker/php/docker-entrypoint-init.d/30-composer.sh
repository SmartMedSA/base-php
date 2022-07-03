#!/usr/bin/env bash
cd "$APP_ROOT" || exit 1

XDEBUG_MODE=off composer install --prefer-dist --optimize-autoloader --no-interaction --no-progress
