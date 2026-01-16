#for already demultiplexed data
#import fastq files as a qza file

##start docker container first
#docker start qiime2.2024.02
#docker exec -i -t qiime2.2024.02 /bin/bash

#change directory to your project folder beforehead

#import raw read data
qiime tools import \
    --type 'SampleData[PairedEndSequencesWithQuality]' \
    --input-path pe_33_manifest.tsv \
    --output-path Analysis/demux/demux-paired-end.qza \
    --input-format PairedEndFastqManifestPhred33V2

#summarize stats of raw read data
qiime demux summarize \
    --i-data Analysis/demux/demux-paired-end.qza \
    --o-visualization Analysis/demux/demux-paired-end.qzv