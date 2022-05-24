#!/usr/bin/env bash
cd "$APP_ROOT" || exit 1

if [[ "$DATABASE_URL" =~ ^sqlite://.* ]]; then
    # Create database.
    bin/console d:s:c   
elif [[ "$DATABASE_URL" =~ ^mysql://.* ]]; then
    # We expect the database to be created at this point.
    bin/console doctrine:migrations:migrate --no-ansi --allow-no-migration --quiet
fi