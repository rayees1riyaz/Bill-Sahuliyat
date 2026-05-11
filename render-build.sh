#!/usr/bin/env bash

bundle install

npm install

npx puppeteer browsers install chrome

rails db:migrate

rails assets:precompile