#!/bin/bash

sudo docker build -t opencb/mongodb       -f Dockerfile.mongodb       .
sudo docker build -t opencb/java8         -f Dockerfile.java8         .
sudo docker build -t opencb/cellbase      -f Dockerfile.cellbase      .
sudo docker build -t opencb/cellbase_load -f Dockerfile.cellbase_load .
sudo docker build -t opencb/cellbase_web  -f Dockerfile.cellbase_web  .

sudo docker run -d -p 31017:27017 -p 31018:28017 --name cb_mongo opencb/mongodb 
sudo docker run -d --link cb_mongo --rm --name cellbase_load opencb/cellbase_load
sudo docker run -d -p 18080:8080 --link cb_mongo  --name cellbase_web opencb/cellbase_web
