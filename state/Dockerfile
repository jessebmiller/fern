from python:alpine

env SHELL /bin/ash

run pip install --upgrade pip
run pip install pipenv

run mkdir /app
workdir /app

run pipenv --three

run apk add --no-cache --virtual .build-deps \
    gcc \
    python3-dev \
    musl-dev \
    postgresql-dev \
    && pipenv install psycopg2 \
    && apk del --no-cache .build-deps \
    && apk add --no-cache libpq

copy Pipfile Pipfile
copy Pipfile.lock Pipfile.lock

run pipenv update


