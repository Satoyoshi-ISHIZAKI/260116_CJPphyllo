#draw phylogenetic trees for merged sequences

##start docker container first
#docker start qiime2.2024.10
#docker exec -i -t qiime2.2024.10 /bin/bash

##16S
#use dada2 outputs with the longer downstream truncation (tr)
qiime alignment mafft \
    --i-sequences Analysis/merge/seq-no-contam_merge2324_16S.qza \
    --o-alignment Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned.qza

qiime alignment mask \
    --i-alignment Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned.qza \
    --o-masked-alignment Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned_masked.qza

qiime phylogeny fasttree \
    --i-alignment Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned_masked.qza \
    --o-tree Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned_masked_tree.qza

qiime phylogeny midpoint-root \
    --i-tree Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned_masked_tree.qza \
    --o-rooted-tree Analysis/phylogeny/seqs_nocontam_merge2324_16S_aligned_masked_tree_rooted.qza

##ITS
qiime alignment mafft \
    --i-sequences Analysis/merge/seq-no-contam_merge2324_ITS.qza \
    --o-alignment Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned.qza

qiime alignment mask \
    --i-alignment Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned.qza \
    --o-masked-alignment Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned_masked.qza

qiime phylogeny fasttree \
    --i-alignment Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned_masked.qza \
    --o-tree Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned_masked_tree.qza

qiime phylogeny midpoint-root \
    --i-tree Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned_masked_tree.qza \
    --o-rooted-tree Analysis/phylogeny/seqs_nocontam_merge2324_ITS_aligned_masked_tree_rooted.qza