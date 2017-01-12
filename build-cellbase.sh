#!/bin/bash

chmod u+x ./bin/cellbase.sh 
DATA='all'
OPTS=" --conf configuration.json --data $DATA "

./bin/cellbase.sh download $OPTS --species celegans --assembly WBcel235 --output ensembl
./bin/cellbase.sh build    $OPTS --species celegans  -a WBcel235 --input ensembl/caenorhabditis_elegans_WBcel235/ --common ensembl/common/ --output celegans/
./bin/cellbase.sh load     $OPTS --input celegans/ --database cellbase_celegans_WBcel235_v4

./bin/cellbase.sh download $OPTS --species scerevisiae --assembly R64-1-1 --output ensembl
./bin/cellbase.sh build    $OPTS --species scerevisiae  -a R64-1-1 --input ensembl/saccharomyces_cerevisiae_R64-1-1/ --common ensembl/common/ --output scerevisiae/
./bin/cellbase.sh load     $OPTS --input scerevisiae/ --database cellbase_scerevisiae_R64-1-1_v4

./bin/cellbase.sh download $OPTS --species drerio --assembly GRCz10 --output ensembl
./bin/cellbase.sh build    $OPTS --species drerio  -a GRCz10 --input ensembl/danio_rerio_GRCz10/ --common ensembl/common/ --output drerio/
./bin/cellbase.sh load     $OPTS --input drerio/ --database cellbase_drerio_GRCz10_v4

./bin/cellbase.sh download $OPTS --species hsapiens --assembly GRCh38 --output ensembl
./bin/cellbase.sh build    $OPTS --species hsapiens  -a GRCh38 --input ensembl/homo_sapiens_GRCh38/ --common ensembl/common/ --output hsapiens/
./bin/cellbase.sh load     $OPTS --input hsapiens/ --database cellbase_hsapiens_GRCh38_v4

./bin/cellbase.sh download $OPTS --species mmusculus --assembly GRCm38 --output ensembl
./bin/cellbase.sh build    $OPTS --species mmusculus  -a GRCm38 --input ensembl/mus_musculus_GRCm38/ --common ensembl/common/ --output mmusculus/
./bin/cellbase.sh load     $OPTS --input mmusculus/ --database cellbase_mmusculus_GRCm38_v4
