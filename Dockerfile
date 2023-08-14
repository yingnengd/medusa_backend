# Set the base image to Node 17.1.0-alpine
FROM node:17.1.0-alpine

# Set the working directory
WORKDIR /app/medusa

# Copy the necessary files
COPY package.json .
COPY develop.sh .
COPY yarn.* .

# Run the apk update command to update package information
RUN apk update

RUN apk add redis
# RUN rc-service redis status
# RUN rc-service redis start

RUN apk add postgresql
# RUN rc-service postgresql status
# RUN rc-service postgresql start

# Install dependencies
RUN yarn --network-timeout 1000000

# Install the medusa-cli
RUN yarn global add @medusajs/medusa-cli@latest

# Add the remaining files
COPY . .

#add user
RUN medusa user -e mei@outlook.com -p Syw!888888

#install pluns
RUN yarn add @medusajs/file-local 

RUN yarn add medusa-plugin-meilisearch 

RUN yarn install

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

EXPOSE 6379 9000 7000 8000

# Set the default command to run when the container starts
ENTRYPOINT ["sh", "develop.sh"]
