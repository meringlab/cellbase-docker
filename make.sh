#!/bin/bash

sudo docker build -t opencb/mongodb       -f Dockerfile.mongodb       .
sudo docker build -t opencb/java8         -f Dockerfile.java8         .
sudo docker build -t opencb/cellbase      -f Dockerfile.cellbase      .
sudo docker build -t opencb/cellbase_load -f Dockerfile.cellbase_load .
sudo docker build -t opencb/cellbase_web  -f Dockerfile.cellbase_web  .
(cd ensembl-docker/db && sudo docker build -t opencb/ensembl-db .)
(cd ensembl-docker/db_download && sudo docker build -t opencb/ensembl-db_download .)

#sudo docker run -d --restart=always -p 31117:27017 -p 31118:28017 --name cb_mongo opencb/mongodb 
##  sudo docker run -d --restart=always -p 31117:27017 -p 31118:28017 --name cb_mongo docker-registry.meringlab.org:5443/opencb/mongodb
#sudo docker run -d --link cb_mongo --rm --name cellbase_load opencb/cellbase_load
#sudo docker run -d --restart=always -p 18080:8080 --link cb_mongo  --name cellbase_web opencb/cellbase_web

docker network create --driver overlay --subnet 10.1.5.0/24 geneassassin-network
# pull the image on the required host and don't pass --with-registry-auth if in swarm mode so it only runs there, then:
#docker service create --name cellbase_mongo_v4 --network=geneassassin-network -p 31117:27017 -p 31118:28017 docker-registry.meringlab.org:5443/opencb/mongodb
docker service create --name cellbase_mongo_v4 --network=geneassassin-network --constraint "node.hostname == imlslnx-titan.uzh.ch" -p 31117:27017 -p 31118:28017 docker-registry.meringlab.org:5443/opencb/mongodb

# setup local ensembl mysql: 
for species in caenorhabditis_elegans_core_85_250 danio_rerio_core_85_10 saccharomyces_cerevisiae_core_85_4 mus_musculus_core_85_38;
do
	rsync -avP rsync://ftp.ensembl.org/ensembl/pub/release-85/mysql/${species} /mnt/local/gene-assassin/load_backup/ftp/
	touch /mnt/local/gene-assassin/load_backup/ftp/${species}.downloaded
done
#sudo docker run -p 15306:5306 -d --name ensembl-db -v /mnt/local/gene-assassin/load_backup/ftp/:/ftp -e 'DB_REMOTE_ROOT_NAME=mysqldba' opencb/ensembl-db

sudo docker run -d --name ensembl-db --log-driver=json-file  -p 11306:3306 -e MYSQL_ROOT_PASSWORD=secret opencb/ensembl-db 
sudo docker exec -it ensembl-db mysql -u root -h ensembl-db -p -e "set sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';GRANT ALL ON *.* TO ''@'%';FLUSH PRIVILEGES;"

sudo docker run --rm --link=ensembl-db -v /mnt/local/gene-assassin/load_backup/ftp:/ftp -ti opencb/ensembl-db_download /sbin/entrypoint.sh caenorhabditis_elegans 85 250
sudo docker run --rm --link=ensembl-db -v /mnt/local/gene-assassin/load_backup/ftp:/ftp -ti opencb/ensembl-db_download /sbin/entrypoint.sh saccharomyces_cerevisiae 85 4
sudo docker run --rm --link=ensembl-db -v /mnt/local/gene-assassin/load_backup/ftp:/ftp -ti opencb/ensembl-db_download /sbin/entrypoint.sh danio_rerio 85 10
sudo docker run --rm --link=ensembl-db -v /mnt/local/gene-assassin/load_backup/ftp:/ftp -ti opencb/ensembl-db_download /sbin/entrypoint.sh mus_musculus 85 38

# to load data 
docker run -d --add-host cb_mongo:130.60.240.80 --rm --name cellbase_load -v /mnt/local/gene-assassin/load_backup/ensembl:/opt/cellbase/build/ensembl -v /mnt/local/gene-assassin/load_backup/build:/opt/cellbase/build/build/ opencb/cellbase_load
# or for interactive run: sudo docker run -it --add-host cb_mongo:130.60.240.80  --name cellbase_load opencb/cellbase_load bash

docker service create --name cellbase_web_v4 --network=geneassassin-network -p 18181:8080  docker-registry.meringlab.org:5443/opencb/cellbase_web