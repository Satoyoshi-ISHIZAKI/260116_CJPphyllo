# filter out singleton features from merged tables and rep-seqs

## Workflow to this file:
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_16S.sh / dada2_ITS.sh / dada2_ITS_2306.sh
## 6. merge.sh
## 7. filter_singltons.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# 16S
qiime feature-table filter-features \
  --i-table Analysis/merge/table_16S_mg.qza \
  --p-min-samples 2 \
  --o-filtered-table Analysis/merge/table_16S_ms2.qza

qiime feature-table filter-seqs \
  --i-data Analysis/merge/seq_16S_mg.qza \
  --i-table Analysis/merge/table_16S_ms2.qza \
  --o-filtered-data Analysis/merge/seq_16S_ms2.qza

# ITS
qiime feature-table filter-features \
  --i-table Analysis/merge/table_ITS_mg.qza \
  --p-min-samples 2 \
  --o-filtered-table Analysis/merge/table_ITS_ms2.qza

qiime feature-table filter-seqs \
  --i-data Analysis/merge/seq_ITS_mg.qza \
  --i-table Analysis/merge/table_ITS_ms2.qza \
  --o-filtered-data Analysis/merge/seq_ITS_ms2.qza

## paired reads for ITS
qiime feature-table filter-features \
  --i-table Analysis/merge/table_ITS_paired_mg.qza \
  --p-min-samples 2 \
  --o-filtered-table Analysis/merge/table_ITS_paired_ms2.qza

qiime feature-table filter-seqs \
  --i-data Analysis/merge/seq_ITS_paired_mg.qza \
  --i-table Analysis/merge/table_ITS_paired_ms2.qza \
  --o-filtered-data Analysis/merge/seq_ITS_paired_ms2.qza

# summary
## 16S
qiime feature-table summarize \
  --i-table Analysis/merge/table_16S_ms2.qza \
  --o-summary Analysis/merge/table_16S_ms2.qzv \
  --o-sample-frequencies Analysis/merge/sample-frequencies_16S_ms2.qza \
  --o-feature-frequencies Analysis/merge/asv-frequencies_16S_ms2.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/merge/seq_16S_ms2.qza \
  --m-metadata-file Analysis/merge/asv-frequencies_16S_ms2.qza \
  --o-visualization Analysis/merge/rep-seqs_16S_ms2.qzv

## ITS
qiime feature-table summarize \
    --i-table Analysis/merge/table_ITS_ms2.qza \
    --o-summary Analysis/merge/table_ITS_ms2.qzv \
    --o-sample-frequencies Analysis/merge/sample-frequencies_ITS_ms2.qza \
    --o-feature-frequencies Analysis/merge/asv-frequencies_ITS_ms2.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/merge/seq_ITS_ms2.qza \
  --m-metadata-file Analysis/merge/asv-frequencies_ITS_ms2.qza \
  --o-visualization Analysis/merge/rep-seqs_ITS_ms2.qzv

## paired reads for ITS
qiime feature-table summarize \
    --i-table Analysis/merge/table_ITS_paired_ms2.qza \
    --o-summary Analysis/merge/table_ITS_paired_ms2.qzv \
    --o-sample-frequencies Analysis/merge/sample-frequencies_ITS_paired_ms2.qza \
    --o-feature-frequencies Analysis/merge/asv-frequencies_ITS_paired_ms2.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/merge/seq_ITS_paired_ms2.qza \
  --m-metadata-file Analysis/merge/asv-frequencies_ITS_paired_ms2.qza \
  --o-visualization Analysis/merge/rep-seqs_ITS_paired_ms2.qzv