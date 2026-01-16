#assign taxonomy to ASVs

##start docker container first
#docker start qiime2.2024.02
#docker exec -i -t qiime2.2024.02 /bin/bash

#change directory to your project folder beforehead

#use UNITE database

#Bokulich et al. (2018). Optimizing taxonomic classification of marker-gene amplicon sequences with QIIME 2’s q2-feature-classifier plugin.
#Abarenkov et al. (2024). The UNITE database for molecular identification and taxonomic communication of fungi and other eukaryotes: sequences, taxa and classifications reconsidered.
#10.15156/BIO/2959338

#make dir
#mkdir ../UNITE_all_20240404

#use qiime2.2024.10 to use scikit-sklearn v 1
#docker start qiime2.2024.10
#docker exec -i -t qiime2.2024.10 /bin/bash

#import repseqs and taxonomy file
qiime tools import \
  --type 'FeatureData[Sequence]' \
  --input-path /data/sh_qiime_release_all_04.04.2024/developer/sh_refs_qiime_ver10_dynamic_all_04.04.2024_dev.fasta \
  --output-path /data/UNITE_all_20240404/unite_refseqs_240404.qza

qiime tools import \
  --type 'FeatureData[Taxonomy]' \
  --input-format HeaderlessTSVTaxonomyFormat \
  --input-path /data/sh_qiime_release_all_04.04.2024/developer/sh_taxonomy_qiime_ver10_dynamic_all_04.04.2024_dev.txt \
  --output-path /data/UNITE_all_20240404/unite_taxonomy_240404.qza

#train classifier
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads /data/UNITE_all_20240404/unite_refseqs_240404.qza \
  --i-reference-taxonomy /data/UNITE_all_20240404/unite_taxonomy_240404.qza \
  --o-classifier /data/UNITE_all_20240404/unite_2404_nb_classifier.qza

#assign taxonomy to ASVs
qiime feature-classifier classify-sklearn \
    --i-reads Analysis/denoised/rep-seqs_ITS.qza \
    --i-classifier /data/UNITE_all_20240404/unite_2404_nb_classifier.qza \
    --o-classification Analysis/taxa/classification_ITS.qza

#barplot
qiime taxa barplot \
    --i-table Analysis/denoised/table_ITS.qza \
    --i-taxonomy Analysis/taxa/classification_ITS.qza \
    --o-visualization Analysis/taxa/taxa_barplot_ITS.qzv

#filter out ASVs that were not assigned to the kingdom "Fungi"
qiime taxa filter-table \
    --i-table Analysis/denoised/table_ITS.qza \
    --i-taxonomy Analysis/taxa/classification_ITS.qza \
    --p-include k__Fungi \
    --o-filtered-table Analysis/NoContam/table-no-contam_ITS.qza

qiime taxa filter-seqs \
    --i-sequences Analysis/denoised/rep-seqs_ITS.qza \
    --i-taxonomy Analysis/taxa/classification_ITS.qza \
    --p-include k__Fungi \
    --o-filtered-sequences Analysis/NoContam/seq-no-contam_ITS.qza

qiime feature-table tabulate-seqs \
    --i-data Analysis/NoContam/seq-no-contam_ITS.qza \
    --o-visualization Analysis/NoContam/seq-no-contam_ITS.qzv

qiime taxa barplot \
    --i-table Analysis/NoContam/table-no-contam_ITS.qza \
    --i-taxonomy Analysis/taxa/classification_ITS.qza \
    --o-visualization Analysis/NoContam/taxa_barplot_ITS.qzv