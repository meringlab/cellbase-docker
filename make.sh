#!/bin/bash

sudo docker build -t opencb/mongodb       -f Dockerfile.mongodb       .
sudo docker build -t opencb/java8         -f Dockerfile.java8         .
sudo docker build -t opencb/cellbase      -f Dockerfile.cellbase      .
sudo docker build -t opencb/cellbase_load -f Dockerfile.cellbase_load .
sudo docker build -t opencb/cellbase_web  -f Dockerfile.cellbase_web  .


#sudo docker run -d --restart=always -p 31117:27017 -p 31118:28017 --name cb_mongo opencb/mongodb 
##  sudo docker run -d --restart=always -p 31117:27017 -p 31118:28017 --name cb_mongo docker-registry.meringlab.org:5443/opencb/mongodb
#sudo docker run -d --link cb_mongo --rm --name cellbase_load opencb/cellbase_load
#sudo docker run -d --restart=always -p 18080:8080 --link cb_mongo  --name cellbase_web opencb/cellbase_web

docker network create --driver overlay --subnet 10.1.5.0/24 geneassassin-network
# pull the image on the required host and don't pass --with-registry-auth if in swarm mode so it only runs there, then:
docker service create --name cellbase_mongo_v4 --network=geneassassin-network -p 31117:27017 -p 31118:28017 docker-registry.meringlab.org:5443/opencb/mongodb
# to load data mongo 
docker run -d --add-host cb_mongo:130.60.240.80 --rm --name cellbase_load opencb/cellbase_load
# or for interactive run: sudo docker run -it --add-host cb_mongo:130.60.240.80  --name cellbase_load opencb/cellbase_load bash

docker service create --name cellbase_web_v4 --network=geneassassin-network -p 18180:8080  docker-registry.meringlab.org:5443/opencb/cellbase_web