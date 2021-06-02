# Client Base
# ------------------------------------------------------------------------------

FROM node:16-alpine3.11 AS client

RUN apk update && apk upgrade && apk add --update --no-cache \
  build-base bash

WORKDIR /client

COPY client/package.json client/yarn.lock ./

RUN yarn install --modules-folder /node_modules

ENV PATH=/node_modules/.bin:${PATH}

COPY client/ ./

# Server Base
# ------------------------------------------------------------------------------
FROM ruby:2.7.2-alpine AS server

RUN apk update && apk upgrade && apk add --update --no-cache \
  build-base bash postgresql-dev tzdata

WORKDIR /server

COPY server/Gemfile server/Gemfile.lock ./

RUN bundle install

COPY server/ ./

# Client Production
# ------------------------------------------------------------------------------
FROM client as client-prod

ARG REACT_APP_API_BASE_URL

RUN yarn build

# Server Production
# ------------------------------------------------------------------------------
FROM server as server-prod

ARG RAILS_ENV

COPY --from=client-prod /client/build /server/public/client
