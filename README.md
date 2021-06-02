docker-compose up

docker-compose run --rm server rails test
docker-compose run --rm client yarn test

http://127.0.0.1:53000 - Server Access
http://127.0.0.1:53001 - Client Access
