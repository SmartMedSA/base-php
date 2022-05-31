#!/usr/bin/env bash
cd "$APP_ROOT" || exit 1

chown -R www-data:www-data "$APP_ROOT"
chown -R www-data:www-data "${PHP_INI_DIR}/conf.d"