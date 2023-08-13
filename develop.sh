#!/bin/bash

#Run migrations to ensure the database is updated
medusa migrations run

#Start development environment
medusa develop

#add user
medusa user -e mei@outlook.com -p Syw!888888

#install pluns
npm install @medusajs/file-local 

npm install medusa-plugin-meilisearch 

npm install