# trim pimer seqs

##start docker container first
#docker start qiime2.2024.02
#docker exec -i -t qiime2.2024.02 /bin/bash

#change directory to your project folder beforehead

#16S 515F GTGYCAGCMGCCGCGGTAA 806R GGACTACNVGGGTWTCTAAT
#ITS fITS9 GAACACAGCGAAATGTGA ITS4ngsuni CCTSCSCTTANTDATATGC 

#trim 16S rRNA gene sequences
qiime cutadapt trim-paired \
    --i-demultiplexed-sequences Analysis/demux/demux-paired-end.qza \
    --p-cores 4 \
    --p-front-f GTGYCAGCMGCCGCGGTAA \
    --p-front-r GGACTACNVGGGTWTCTAAT \
    --p-discard-untrimmed \
    --p-no-indels \
    --o-trimmed-sequences Analysis/demux/trimmed_paired-end_16S.qza

qiime demux summarize \
    --i-data Analysis/demux/trimmed_paired-end_16S.qza \
    --o-visualization Analysis/demux/trimmed_paired-end_16S.qzv

#ITS(address the read through problem)
#remove compliment sequences of opposite primer seqs from each seqs as adapter sequences
qiime cutadapt trim-paired \
    --i-demultiplexed-sequences Analysis/demux/demux-paired-end.qza \
    --p-cores 4 \
    --p-adapter-f GCATATHANTAAGSGSAGG \
    --p-front-f GAACACAGCGAAATGTGA \
    --p-adapter-r TCACATTTCGCTGTGTTC \
    --p-front-r CCTSCSCTTANTDATATGC \
    --p-discard-untrimmed \
    --p-no-indels \
    --o-trimmed-sequences Analysis/demux/trimmed_paired-end_ITS.qza

qiime demux summarize \
    --i-data Analysis/demux/trimmed_paired-end_ITS.qza \
    --o-visualization Analysis/demux/trimmed_paired-end_ITS.qzv