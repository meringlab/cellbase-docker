#!/bin/bash

chmod u+x ./bin/cellbase.sh 
DATA='all'
OPTS=" --config configuration.json --data $DATA "

./bin/cellbase.sh download $OPTS --species celegans --assembly WBcel235 --output ensembl
./bin/cellbase.sh build    $OPTS --species celegans  -a WBcel235 --input ensembl/caenorhabditis_elegans_wbcel235/ --common ensembl/common/ --output celegans/
./bin/cellbase.sh load     $OPTS --input celegans/ --database cellbase_celegans_wbcel235_v4

./bin/cellbase.sh download $OPTS --species scerevisiae --assembly R64-1-1 --output ensembl
./bin/cellbase.sh build    $OPTS --species scerevisiae  -a R64-1-1 --input ensembl/saccharomyces_cerevisiae_r64-1-1/ --common ensembl/common/ --output scerevisiae/
./bin/cellbase.sh load     $OPTS --input scerevisiae/ --database cellbase_scerevisiae_r64-1-1_v4

./bin/cellbase.sh download $OPTS --species drerio --assembly GRCz10 --output ensembl
./bin/cellbase.sh build    $OPTS --species drerio  -a GRCz10 --input ensembl/danio_rerio_grcz10/ --common ensembl/common/ --output drerio/
./bin/cellbase.sh load     $OPTS --input drerio/ --database cellbase_drerio_grcz10_v4

# human is usualy built by opencb guys: 
# http://bioinfo.hpc.cam.ac.uk/downloads/cellbase/v4/homo_sapiens_grch38/mongodb/
#./bin/cellbase.sh download $OPTS --species hsapiens --assembly GRCh38 --output ensembl
#./bin/cellbase.sh build    $OPTS --species hsapiens  -a GRCh38 --input ensembl/homo_sapiens_GRCh38/ --common ensembl/common/ --output hsapiens/

mkdir ensemgl/hsapiens && cd ensembl/hsapiens
HSURL='http://bioinfo.hpc.cam.ac.uk/downloads/cellbase/v4/homo_sapiens_grch38/mongodb/'
wget $HSURL
awk -F '"' '/"[\.a-z0-9A-Z]+\"/ {print $8 }' index.html | grep '\.' > files.txt
for f in `cat files.txt`; do wget "http://bioinfo.hpc.cam.ac.uk/downloads/cellbase/v4/homo_sapiens_grch38/mongodb/$f"; done
cd ../../

./bin/cellbase.sh load     $OPTS --input hsapiens/ --database cellbase_hsapiens_grch38_v4


./bin/cellbase.sh download $OPTS --species mmusculus --assembly GRCm38 --output ensembl
./bin/cellbase.sh build    $OPTS --species mmusculus  -a GRCm38 --input ensembl/mus_musculus_grcm38/ --common ensembl/common/ --output mmusculus/
./bin/cellbase.sh load     $OPTS --input mmusculus/ --database cellbase_mmusculus_grcm38_v4
