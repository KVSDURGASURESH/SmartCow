#!/bin/sh

# npm install
# # npm build
# npm start

## Alternatively can use YARN

yarn cache clean
yarn config set registry https://registry.npmjs.org
rm yarn.lock
yarn
yarn install
yarn build
yarn start