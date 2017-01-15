Build
================

    cd ensembl-docker/db
    docker build -t opencb/ensembl-db .

Run
==============

Run the docker images which setup the first instance of MySQL.
    

    docker run -p 15306:3306 -d --name ensembl-db -v /mnt/cdata/db/ensembl/log:/var/log/mysql -v /mnt/cdata/db/ensembl/mysql:/var/lib/mysql -v /mnt/cdata/db/ensembl/ftp:/ftp  opencb/ensembl-db

Initialize a database with the desired specie release and genome version

    docker run --rm --link=ensembl-db -v /mnt/cdata/db/ensembl/ftp:/ftp -ti helios/ensembl-db-download homo_sapiens 81 38
