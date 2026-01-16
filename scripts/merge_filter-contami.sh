#filter out contamination (mitochondria, chloroplast)

##start docker container first
#docker start qiime2.2024.10
#docker exec -i -t qiime2.2024.10 /bin/bash

#16S
qiime taxa filter-table \
    --i-table 241120_phyllo/Analysis/merge/table_merge2324_16S.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_16S.qza \
    --p-exclude mitochondria,chloroplast,Unassigned,d__Eukaryota \
    --p-include d__Bacteria \
    --o-filtered-table 241120_phyllo/Analysis/merge/table-no-contam_merge2324_16S.qza

qiime taxa filter-seqs \
    --i-sequences 241120_phyllo/Analysis/merge/seq_merge2324_16S.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_16S.qza \
    --p-exclude mitochondria,chloroplast,Unassigned,d__Eukaryota \
    --p-include d__Bacteria \
    --o-filtered-sequences 241120_phyllo/Analysis/merge/seq-no-contam_merge2324_16S.qza

qiime taxa barplot \
    --i-table 241120_phyllo/Analysis/merge/table-no-contam_merge2324_16S.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_16S.qza \
    --o-visualization 241120_phyllo/Analysis/merge/taxa_barplot-no-contam_merge2324_16S.qzv

#ITS
qiime taxa filter-table \
    --i-table 241120_phyllo/Analysis/merge/table_merge2324_ITS.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qza \
    --p-include k__Fungi \
    --o-filtered-table 241120_phyllo/Analysis/merge/table-no-contam_merge2324_ITS.qza

qiime taxa filter-seqs \
    --i-sequences 241120_phyllo/Analysis/merge/seq_merge2324_ITS.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qza \
    --p-include k__Fungi \
    --o-filtered-sequences 241120_phyllo/Analysis/merge/seq-no-contam_merge2324_ITS.qza

qiime taxa barplot \
    --i-table 241120_phyllo/Analysis/merge/table-no-contam_merge2324_ITS.qza \
    --i-taxonomy 241120_phyllo/Analysis/merge/classification_merge2324_ITS.qza \
    --o-visualization 241120_phyllo/Analysis/merge/taxa_barplot-no-contam_merge2324_ITS.qzv