#!/bin/sh

## Can use NPM for dev like environments

# npm install
# # npm build
# npm start

## Alternatively can use YARN for production like environments

yarn cache clean
yarn config set registry https://registry.npmjs.org
rm yarn.lock
yarn
yarn install
yarn build
yarn start