## Cafe Menu App

This is a web application for creating a cafe menu

Find the deployed application [HERE](https://cafe-menus-app.herokuapp.com/)

## Starting Services for Development

```bash

$ docker-compose up

```

## Running Tests

```bash

# Running server tests
$ docker-compose run --rm server rails test

# Running client tests
$ docker-compose run --rm client yarn test

```

## Browse Client

Ensure all services are runnning (db, client, server)

```bash

$ open http://127.0.0.1:53001

```
