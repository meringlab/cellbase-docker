#!/bin/bash

chmod u+x ./bin/cellbase.sh 
DATA='all'
OPTS=" --conf configuration.json --data $DATA "
./bin/cellbase.sh download $OPTS --species "Danio rerio" --assembly Zv9 --output ensembl
./bin/cellbase.sh build    $OPTS --species drerio  -a Zv9 --input ensembl/danio_rerio_zv9/ --common ensembl/common/ --output drerio/
./bin/cellbase.sh load     $OPTS --input drerio/ --database cellbase_drerio_zv9_v3
