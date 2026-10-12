#!/bin/bash
# Выполняется один раз при первом создании тома с данными.
# Имена баз, пользователей и пароли приходят из переменных окружения.
set -e

create_db() {
  local db="$1" user="$2" password="$3"

  if [ -z "$db" ] || [ -z "$user" ] || [ -z "$password" ]; then
    echo "ERROR: пустое имя базы, пользователя или пароль" >&2
    exit 1
  fi

  echo "Creating database '$db' with owner '$user'"
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname postgres <<-SQL
    CREATE USER "$user" WITH PASSWORD '$password';
    CREATE DATABASE "$db" OWNER "$user";
    -- другие сервисы не могут подключаться к чужой базе
    REVOKE ALL ON DATABASE "$db" FROM PUBLIC;
    GRANT ALL PRIVILEGES ON DATABASE "$db" TO "$user";
SQL
}

create_db "$PARSER_DB_NAME"        "$PARSER_DB_USER"        "$PARSER_DB_PASSWORD"
create_db "$BACKOFFICE_DB_NAME"    "$BACKOFFICE_DB_USER"    "$BACKOFFICE_DB_PASSWORD"
create_db "$CLIENT_FINDER_DB_NAME" "$CLIENT_FINDER_DB_USER" "$CLIENT_FINDER_DB_PASSWORD"
create_db "$BOT_DB_NAME"           "$BOT_DB_USER"           "$BOT_DB_PASSWORD"