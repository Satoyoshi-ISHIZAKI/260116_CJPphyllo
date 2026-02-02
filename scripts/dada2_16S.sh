# QC and inference of ASVs

## Workflow to this file: 
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_16S.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# change directory to your project folder beforehand

# make directory
# mkdir Analysis/denoised

## modify length to be trimmed and truncated according to your data quality

## overlap should be > 20 (preferably > 100 ?)
## weaker quality filter

qiime dada2 denoise-paired \
    --i-demultiplexed-seqs Analysis/demux/trimmed_paired-end_16S.qza \
    --p-trim-left-f 0 \
    --p-trim-left-r 0 \
    --p-trunc-len-f 250 \
    --p-trunc-len-r 180 \
    --p-n-threads 0 \
    --p-min-overlap 20 \
    --p-retain-all-samples True \
    --o-representative-sequences Analysis/denoised/rep-seqs_16S.qza \
    --o-table Analysis/denoised/table_16S.qza \
    --o-denoising-stats Analysis/denoised/denoising-stats_16S.qza \
    --o-base-transition-stats Analysis/denoised/base-transition-stats_16S.qza

qiime feature-table summarize \
    --i-table Analysis/denoised/table_16S.qza \
    --o-visualization Analysis/denoised/table_16S.qzv

qiime feature-table tabulate-seqs \
    --i-data Analysis/denoised/rep-seqs_16S.qza \
    --o-visualization Analysis/denoised/rep-seqs_16S.qzv

#stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/denoising-stats_16S.qza \
    --o-visualization Analysis/denoised/denoising-stats_16S.qzv

qiime tools export \
    --input-path Analysis/denoised/denoising-stats_16S.qza \
    --output-path Analysis/denoised/dada2_output_16S