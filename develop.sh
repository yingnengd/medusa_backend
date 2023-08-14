#!/bin/bash

#Run migrations to ensure the database is updated
medusa migrations run

#Start development environment
medusa develop

#add user
medusa user -e mei@outlook.com -p Syw!888888

#install pluns
yarn add @medusajs/file-local 

yarn add medusa-plugin-meilisearch 

yarn install

cat <<EOF >> /etc/postgresql/pg_hba.conf host all all 0.0.0.0/0 md5 EOF
cat <<EOF >> /etc/postgresql/postgresql.conf listen_addresses = '*' EOF


access the postgres console
psql postgres

#使用 postgres 用户登录
psql -U yynid

#postgres=# 是 postgres 提示符 为 postgres 用户设置密码
postgres=# \password Syw!888888

# create a new database and the newly created user as the owner
CREATE DATABASE medusa_db OWNER yynid;

# grant all privileges on medusa_db to the medusa_admin user
GRANT ALL PRIVILEGES ON DATABASE medusa_db TO yynid;

# exit the postgres console
quit

