# Server Image
# ------------------------------------------------------------------------------

FROM ruby:2.7.2-alpine AS server

RUN apk update && apk upgrade && apk add --update --no-cache \
  build-base wait4ports bash postgresql-dev tzdata

WORKDIR /server

COPY server/Gemfile server/Gemfile.lock ./

RUN bundle install

COPY server/ ./

# Client Image
# ------------------------------------------------------------------------------

FROM node:16-alpine3.11 AS client

RUN apk update && apk upgrade && apk add --update --no-cache \
  build-base wait4ports bash

WORKDIR /client

COPY client/package.json client/yarn.lock ./

RUN yarn install --modules-folder /node_modules

ENV PATH=/node_modules/.bin:${PATH}

COPY client/ ./
