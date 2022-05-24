#!/usr/bin/env bash
cd "$APP_ROOT" || exit 1

composer install
composer dump-autoload --optimize