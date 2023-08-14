#!/bin/bash

#Run migrations to ensure the database is updated
medusa migrations run

#Start development environment
medusa develop

# rc-update命令将其添加到启动项中。
rc-update add redis

#add user
medusa user -e mei@outlook.com -p Syw!888888

#install pluns
yarn add @medusajs/file-local 

yarn add medusa-plugin-meilisearch 

yarn install
