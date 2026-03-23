# export analysed data to tsv

## Workflow to this file:
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_16S.sh, dada2_ITS.sh
## 6. merge.sh
## 7. filter_singltons.sh
## 8. classifier_install.sh
## 9. taxomony_16S.sh, taxonomy_ITS.sh
## 10. phylogeny.sh
## 11. export.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# mkdir Analysis/export
# mkdir Analysis/export/NoContam
# mkdir Analysis/export/phlogeny
# mkdir Analysis/export/taxa

# 16S
qiime tools export \
    --input-path Analysis/NoContam/seq_16S_nocontam.qza \
    --output-path Analysis/export/NoContam/seq_16S_nocontam
qiime tools export \
    --input-path Analysis/NoContam/table_16S_nocontam.qza \
    --output-path Analysis/export/NoContam/table_16S_nocontam
qiime tools export \
    --input-path Analysis/phylogeny/tree_rooted_16S.qza \
    --output-path Analysis/export/phlogeny/tree_rooted_16S
qiime tools export \
    --input-path Analysis/taxa/classification_16S.qza \
    --output-path Analysis/export/taxa/classification_16S

# ITS
qiime tools export \
    --input-path Analysis/NoContam/seq_ITS_paired_nocontam.qza \
    --output-path Analysis/export/NoContam/seq_ITS_paired_nocontam
qiime tools export \
    --input-path Analysis/NoContam/table_ITS_paired_nocontam.qza \
    --output-path Analysis/export/NoContam/table_ITS_paired_nocontam
qiime tools export \
    --input-path Analysis/phylogeny/tree_rooted_ITS_paired.qza \
    --output-path Analysis/export/phlogeny/tree_rooted_ITS_paired
qiime tools export \
    --input-path Analysis/taxa/classification_ITS_paired.qza \
    --output-path Analysis/export/taxa/classification_ITS_paired