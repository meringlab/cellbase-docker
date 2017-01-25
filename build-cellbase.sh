#!/bin/bash

chmod u+x ./bin/cellbase.sh 
DATA='all'
OPTS=" --config configuration.json --data $DATA --log-level debug "
mkdir build

./bin/cellbase.sh download $OPTS --species celegans --assembly WBcel235 --output ensembl
./bin/cellbase.sh build    $OPTS --species celegans  -a WBcel235 --input ensembl/caenorhabditis_elegans_wbcel235/ --common ensembl/common/ --output build/celegans/
./bin/cellbase.sh load     $OPTS --input build/celegans/ --database cellbase_celegans_wbcel235_v4

./bin/cellbase.sh download $OPTS --species scerevisiae --assembly R64-1-1 --output ensembl
./bin/cellbase.sh build    $OPTS --species scerevisiae  -a R64-1-1 --input ensembl/saccharomyces_cerevisiae_r64-1-1/ --common ensembl/common/ --output build/scerevisiae/
./bin/cellbase.sh load     $OPTS --input build/scerevisiae/ --database cellbase_scerevisiae_r6411_v4

./bin/cellbase.sh download $OPTS --species drerio --assembly GRCz10 --output ensembl
./bin/cellbase.sh build    $OPTS --species drerio  -a GRCz10 --input ensembl/danio_rerio_grcz10/ --common ensembl/common/ --output build/drerio/
./bin/cellbase.sh load     $OPTS --input build/drerio/ --database cellbase_drerio_grcz10_v4

# human is usualy built by opencb guys: 
# http://bioinfo.hpc.cam.ac.uk/downloads/cellbase/v4/homo_sapiens_grch38/mongodb/
#./bin/cellbase.sh download $OPTS --species hsapiens --assembly GRCh38 --output ensembl
#./bin/cellbase.sh build    $OPTS --species hsapiens  -a GRCh38 --input ensembl/homo_sapiens_GRCh38/ --common ensembl/common/ --output hsapiens/

mkdir build/hsapiens && cd build/hsapiens
HSURL='http://bioinfo.hpc.cam.ac.uk/downloads/cellbase/v4/homo_sapiens_grch38/mongodb/'
wget $HSURL
awk -F '"' '/"[\.a-z0-9A-Z]+\"/ {print $8 }' index.html | grep '\.' > files.txt
for f in `cat files.txt`; do wget "http://bioinfo.hpc.cam.ac.uk/downloads/cellbase/v4/homo_sapiens_grch38/mongodb/$f"; done
cd ../../

./bin/cellbase.sh load     $OPTS --input build/hsapiens/ --database cellbase_hsapiens_grch38_v4


./bin/cellbase.sh download $OPTS --species mmusculus --assembly GRCm38 --output ensembl
./bin/cellbase.sh build    $OPTS --species mmusculus  -a GRCm38 --input ensembl/mus_musculus_grcm38/ --common ensembl/common/ --output build/mmusculus/
./bin/cellbase.sh load     $OPTS --input build/mmusculus/ --database cellbase_mmusculus_grcm38_v4
