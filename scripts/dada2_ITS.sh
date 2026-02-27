# QC and inference of ASVs

## Workflow to this file:
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_ITS.sh (this file)

## start docker container first
# docker start qiime2.2024.02
# docker exec -i -t qiime2.2024.02 /bin/bash
# change directory to your project folder beforehand

# make directory
# mkdir Analysis/denoised

# perform QC and denoising using only forward reads
## Use the same trunc-len value as used for the previous data (see shCodes/qiime_231202_SugiJune.txt)
qiime dada2 denoise-single \
  --i-demultiplexed-seqs Analysis/demux/trimmed_paired-end_ITS.qza \
  --p-trim-left 0 \
  --p-trunc-len 250 \
  --p-n-threads 0 \
  --p-retain-all-samples True \
  --o-representative-sequences Analysis/denoised/rep-seqs_ITS.qza \
  --o-table Analysis/denoised/table_ITS.qza \
  --o-denoising-stats Analysis/denoised/denoising-stats_ITS.qza \
  --o-base-transition-stats Analysis/denoised/base-transition-stats_ITS.qza

qiime feature-table summarize \
  --i-table Analysis/denoised/table_ITS.qza \
  --o-summary Analysis/denoised/table_ITS.qzv \
  --o-sample-frequencies Analysis/denoised/sample-frequencies_ITS.qza \
  --o-feature-frequencies Analysis/denoised/asv-frequencies_ITS.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/denoised/rep-seqs_ITS.qza \
  --m-metadata-file Analysis/denoised/asv-frequencies_ITS.qza \
  --o-visualization Analysis/denoised/rep-seqs_ITS.qzv

#stats visualization
qiime metadata tabulate \
  --m-input-file Analysis/denoised/denoising-stats_ITS.qza \
  --o-visualization Analysis/denoised/denoising-stats_ITS.qzv

qiime tools export \
    --input-path Analysis/denoised/denoising-stats_ITS.qza \
    --output-path Analysis/denoised/dada2_output_ITS
# base transition stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/base-transition-stats_ITS.qza \
    --o-visualization Analysis/denoised/base-transition-stats_ITS.qzv

# Denoise with paired reads
qiime dada2 denoise-paired \
    --i-demultiplexed-seqs Analysis/demux/trimmed_paired-end_ITS.qza \
    --p-trim-left-f 0 \
    --p-trim-left-r 0 \
    --p-trunc-len-f 250 \
    --p-trunc-len-r 180 \
    --p-n-threads 0 \
    --p-min-overlap 20 \
    --p-retain-all-samples True \
    --o-representative-sequences Analysis/denoised/rep-seqs_ITS_paired.qza \
    --o-table Analysis/denoised/table_ITS_paired.qza \
    --o-denoising-stats Analysis/denoised/denoising-stats_ITS_paired.qza \
    --o-base-transition-stats Analysis/denoised/base-transition-stats_ITS_paired.qza

qiime feature-table summarize \
  --i-table Analysis/denoised/table_ITS_paired.qza \
  --o-summary Analysis/denoised/table_ITS_paired.qzv \
  --o-sample-frequencies Analysis/denoised/sample-frequencies_ITS_paired.qza \
  --o-feature-frequencies Analysis/denoised/asv-frequencies_ITS_paired.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/denoised/rep-seqs_ITS_paired.qza \
  --m-metadata-file Analysis/denoised/asv-frequencies_ITS_paired.qza \
  --o-visualization Analysis/denoised/rep-seqs_ITS_paired.qzv

#stats visualization
qiime metadata tabulate \
  --m-input-file Analysis/denoised/denoising-stats_ITS_paired.qza \
  --o-visualization Analysis/denoised/denoising-stats_ITS_paired.qzv

qiime tools export \
    --input-path Analysis/denoised/denoising-stats_ITS_paired.qza \
    --output-path Analysis/denoised/dada2_output_ITS_paired

# base transition stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/base-transition-stats_ITS_paired.qza \
    --o-visualization Analysis/denoised/base-transition-stats_ITS_paired.qzv