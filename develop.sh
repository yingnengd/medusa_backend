#!/bin/bash
yarn init 

yarn install 

apk add redis
rc-service redis status
rc-service redis start

apk add postgresql
rc-service postgresql status
rc-service postgresql start

#Run migrations to ensure the database is updated
medusa migrations run

#Start development environment
medusa develop

cat <<EOF >> /etc/postgresql/pg_hba.conf host all all 0.0.0.0/0 md5 EOF
cat <<EOF >> /etc/postgresql/postgresql.conf listen_addresses = '*' EOF

access the postgres console
RUN psql postgres

#使用 postgres 用户登录
RUN psql -U yynid

#postgres=# 是 postgres 提示符 为 postgres 用户设置密码
RUN postgres=# \password Syw!888888

# create a new database and the newly created user as the owner
RUN CREATE DATABASE medusa_db OWNER yynid;

# grant all privileges on medusa_db to the medusa_admin user
RUN GRANT ALL PRIVILEGES ON DATABASE medusa_db TO yynid;

#quit the postgres console
quit
