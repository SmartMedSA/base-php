#!/usr/bin/env bash

set -eo pipefail

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

_gotpl() {
    if [[ -f "/etc/gotpl/$1" ]]; then
        gotpl "/etc/gotpl/$1" > "$2"
    fi
}

process_templates() {
    local php_ver_minor="${PHP_VERSION:0:3}"
    export PHP_VER_MINOR="${php_ver_minor}"

    # Extensions that don't work with --enabled-debug
    _gotpl "docker-php-${php_ver_minor}.ini.tmpl" "${PHP_INI_DIR}/conf.d/docker-php.ini"
    _gotpl "docker-php-ext-apcu.ini.tmpl" "${PHP_INI_DIR}/conf.d/docker-php-ext-apcu.ini"
    _gotpl "docker-php-ext-brotli.ini.tmpl" "${PHP_INI_DIR}/conf.d/docker-php-ext-brotli.ini"
    _gotpl "docker-php-ext-xdebug.ini.tmpl" "${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini"
    _gotpl "docker-php-ext-opcache.ini.tmpl" "${PHP_INI_DIR}/conf.d/docker-php-ext-opcache.ini"
    _gotpl "docker-php-ext-pcov.ini.tmpl" "${PHP_INI_DIR}/conf.d/docker-php-ext-pcov.ini"
}

disable_modules() {
    local dir="${PHP_INI_DIR}/conf.d"

    if [[ -n "${PHP_EXTENSIONS_DISABLE}" ]]; then
        IFS=',' read -r -a modules <<< "${PHP_EXTENSIONS_DISABLE}"

        for module in "${modules[@]}"; do
            if [[ -f "${dir}/z-docker-php-ext-${module}.ini" ]]; then
                rm "${dir}/z-docker-php-ext-${module}.ini";
            elif [[ -f "${dir}/docker-php-ext-${module}.ini" ]]; then
                rm "${dir}/docker-php-ext-${module}.ini";
            else
                echo "WARNING: instructed to disable module ${module} but it was not found"
            fi
        done
    fi
}

sudo init_container
process_templates
disable_modules

exec_init_scripts

if [[ "${1}" == "make" ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec /usr/local/bin/docker-php-entrypoint "${@}"
fi
