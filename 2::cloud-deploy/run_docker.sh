#!/bin/sh

# Kill the older docker processes
echo "killing old docker processes"
docker-compose rm -fs

# # # remove the older images 
# # docker rmi -f $(for i in $(docker-compose images | awk 'NR>2 {print $4}'); do echo $i;done)

# building docker containers and bring them up
# echo "building docker containers"
# docker-compose up --build -d


# building docker containers 
echo "building docker containers"
docker-compose build


# # # # Pushing the docker artifacts to docker registry ex:aws
# echo "pushing docker containers to aws"
# docker-compose push
