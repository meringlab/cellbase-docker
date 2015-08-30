#!/bin/bash

chmod u+x ./bin/cellbase.sh 
DATA='all'
OPTS=" --conf configuration.json --data $DATA "
./bin/cellbase.sh download $OPTS --species "Danio rerio" --output ensembl
./bin/cellbase.sh build    $OPTS --species "Danio rerio" --input ensembl/danio_rerio_zv9/ --common ensembl/common/ --output drerio/
./bin/cellbase.sh load     $OPTS --input drerio/ --database cellbase_drerio_zv9_v3
