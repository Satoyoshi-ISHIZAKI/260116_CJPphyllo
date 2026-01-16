#draw barplots for the merged table

##start docker container first
#docker start qiime2.2024.10
#docker exec -i -t qiime2.2024.10 /bin/bash

qiime feature-classifier classify-sklearn \
    --i-reads 241120_phyllo/Analysis/merge/seq_merge2324_16S.qza \
    --i-classifier SILVA_202410/silva_2410_nb_classifier.qza \
    --o-classification 241120_phyllo/Analysis/merge/classification_merge2324_16S.qza

qiime metadata tabulate \
    --m-input-file 241120_phyllo/Analysis/merge/classification_merge2324_16S.qza \
    --m-input-file 241120_phyllo/Analysis/merge/seq_merge2324_16S.qza \
    --o-visualization 241120_phyllo/Analysis/merge/classification_merge2324_16S.qzv

#barplot
qiime taxa barplot \
    --i-table 241120_phyllo/Analysis/merge/table_merge2324_16S.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_16S.qza \
    --o-visualization 241120_phyllo/Analysis/merge/taxa_barplot_merge2324_16S.qzv

##ITS
qiime feature-classifier classify-sklearn \
    --i-reads 241120_phyllo/Analysis/merge/seq_merge2324_ITS.qza \
    --i-classifier UNITE_all_20240404/unite_2404_nb_classifier.qza \
    --o-classification 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qza

qiime metadata tabulate \
    --m-input-file 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qza \
    --m-input-file 241120_phyllo/Analysis/merge/seq_merge2324_ITS.qza \
    --o-visualization 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qzv

#barplot
qiime taxa barplot \
    --i-table 241120_phyllo/Analysis/merge/table_merge2324_ITS.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qza \
    --o-visualization 241120_phyllo/Analysis/merge/taxa_barplot_merge2324_ITS.qzv