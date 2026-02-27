# QC and inference of ASVs

## Workflow to this file:
## 0. add trimmed ITS data collected in June 2023 to Analysis/demux/231202/trimmed-paired-end_ITS.qza, qzv
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_ITS_2306.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash
# change directory to your project folder beforehand

# make directory
# mkdir Analysis/denoised

# perform QC and denoising using only forward reads
## Use the same trunc-len value as used for the 260116 data (see scripts/dada2_ITS.sh)

# Denoise with paired reads
qiime dada2 denoise-paired \
    --i-demultiplexed-seqs Analysis/demux/231202/trimmed_paired-end_ITS.qza \
    --p-trim-left-f 0 \
    --p-trim-left-r 0 \
    --p-trunc-len-f 250 \
    --p-trunc-len-r 180 \
    --p-n-threads 0 \
    --p-min-overlap 20 \
    --p-retain-all-samples True \
    --o-representative-sequences Analysis/denoised/231202/rep-seqs_ITS_paired.qza \
    --o-table Analysis/denoised/231202/table_ITS_paired.qza \
    --o-denoising-stats Analysis/denoised/231202/denoising-stats_ITS_paired.qza \
    --o-base-transition-stats Analysis/denoised/231202/base-transition-stats_ITS_paired.qza

qiime feature-table summarize \
  --i-table Analysis/denoised/231202/table_ITS_paired.qza \
  --o-summary Analysis/denoised/231202/table_ITS_paired.qzv \
  --o-sample-frequencies Analysis/denoised/231202/sample-frequencies_ITS_paired.qza \
  --o-feature-frequencies Analysis/denoised/231202/asv-frequencies_ITS_paired.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/denoised/231202/rep-seqs_ITS_paired.qza \
  --m-metadata-file Analysis/denoised/231202/asv-frequencies_ITS_paired.qza \
  --o-visualization Analysis/denoised/231202/rep-seqs_ITS_paired.qzv

#stats visualization
qiime metadata tabulate \
  --m-input-file Analysis/denoised/231202/denoising-stats_ITS_paired.qza \
  --o-visualization Analysis/denoised/231202/denoising-stats_ITS_paired.qzv

qiime tools export \
    --input-path Analysis/denoised/231202/denoising-stats_ITS_paired.qza \
    --output-path Analysis/denoised/231202/dada2_output_ITS_paired

# base transition stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/231202/base-transition-stats_ITS_paired.qza \
    --o-visualization Analysis/denoised/231202/base-transition-stats_ITS_paired.qzv