# assign taxonomy to ASVs

## Workflow to this file:
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_ITS.sh, dada2_ITS_2306.sh
## 6. merge.sh
## 7. filter_singltons.sh
## 8. classifier_install.sh
## 9. taxomony_ITS_paired.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# change directory to your project folder beforehand

# use UNITE database

# Bokulich et al. (2018). Optimizing taxonomic classification of marker-gene amplicon sequences with QIIME 2’s q2-feature-classifier plugin.
# Abarenkov et al. (2024). The UNITE database for molecular identification and taxonomic communication of fungi and other eukaryotes: sequences, taxa and classifications reconsidered.
# 10.15156/BIO/2959338

# use qiime2.(version) to use scikit-sklearn v 1
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# use pre-trained classifier from UNITE 2025.02 release, distributed by Colin J. Brislawn, one of the QIIME2 developers.

# assign taxonomy to ASVs
qiime feature-classifier classify-sklearn \
  --i-classifier classifiers/unite_ver2025-02-19_dynamic_eukaryotes-Q2-2026.1.qza \
  --i-reads Analysis/merge/seq_ITS_paired_ms2.qza \
  --o-classification Analysis/taxa/classification_ITS_paired.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/merge/seq_ITS_paired_ms2.qza \
  --i-taxonomy Analysis/taxa/classification_ITS_paired.qza \
  --m-metadata-file Analysis/merge/asv-frequencies_ITS_paired_ms2.qza \
  --o-visualization Analysis/taxa/classification_ITS_paired.qzv

# barplot
qiime taxa barplot \
  --i-table Analysis/merge/table_ITS_paired_ms2.qza \
  --i-taxonomy Analysis/taxa/classification_ITS_paired.qza \
  --o-visualization Analysis/taxa/barplots_ITS_paired_ms2.qzv

# filter out ASVs that were not assigned to the kingdom "Fungi"
qiime taxa filter-table \
    --i-table Analysis/merge/table_ITS_paired_ms2.qza \
    --i-taxonomy Analysis/taxa/classification_ITS_paired.qza \
    --p-include k__Fungi \
    --o-filtered-table Analysis/NoContam/table_ITS_paired_nocontam.qza

qiime taxa filter-seqs \
    --i-sequences Analysis/merge/seq_ITS_paired_ms2.qza \
    --i-taxonomy Analysis/taxa/classification_ITS_paired.qza \
    --p-include k__Fungi \
    --o-filtered-sequences Analysis/NoContam/seq_ITS_paired_nocontam.qza

qiime taxa barplot \
    --i-table Analysis/NoContam/table_ITS_paired_nocontam.qza \
    --i-taxonomy Analysis/taxa/classification_ITS_paired.qza \
    --o-visualization Analysis/NoContam/barplots_ITS_paired_nocontam.qzv

# summary
qiime feature-table summarize \
  --i-table Analysis/NoContam/table_ITS_paired_nocontam.qza \
  --o-summary Analysis/NoContam/table_ITS_paired_nocontam.qzv \
  --o-sample-frequencies Analysis/NoContam/sample-frequencies_ITS_paired_nocontam.qza \
  --o-feature-frequencies Analysis/NoContam/asv-frequencies_ITS_paired_nocontam.qza

qiime feature-table tabulate-seqs \
  --i-data Analysis/NoContam/seq_ITS_paired_nocontam.qza \
  --i-taxonomy Analysis/taxa/classification_ITS_paired.qza \
  --m-metadata-file Analysis/NoContam/asv-frequencies_ITS_paired_nocontam.qza \
  --p-merge-method intersect \
  --o-visualization Analysis/NoContam/seq_ITS_paired_nocontam_taxa.qzv