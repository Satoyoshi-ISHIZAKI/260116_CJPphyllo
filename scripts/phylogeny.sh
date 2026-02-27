# draw phylogenetic trees

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
## 10. phylogeny.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# mkdir Analysis/phylogeny

## 16S
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences Analysis/NoContam/seq_16S_nocontam.qza \
  --o-alignment Analysis/phylogeny/seqs_16S_nocontam_aligned.qza \
  --o-masked-alignment Analysis/phylogeny/seqs_16S_nocontam_aligned_masked.qza \
  --o-tree Analysis/phylogeny/tree_unrooted_16S.qza \
  --o-rooted-tree Analysis/phylogeny/tree_rooted_16S.qza

##ITS
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences Analysis/NoContam/seq_ITS_nocontam.qza \
  --o-alignment Analysis/phylogeny/seqs_ITS_nocontam_aligned.qza \
  --o-masked-alignment Analysis/phylogeny/seqs_ITS_nocontam_aligned_masked.qza \
  --o-tree Analysis/phylogeny/tree_unrooted_ITS.qza \
  --o-rooted-tree Analysis/phylogeny/tree_rooted_ITS.qza

### paired reads for ITS
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences Analysis/NoContam/seq_ITS_paired_nocontam.qza \
  --o-alignment Analysis/phylogeny/seqs_ITS_paired_nocontam_aligned.qza \
  --o-masked-alignment Analysis/phylogeny/seqs_ITS_paired_nocontam_aligned_masked.qza \
  --o-tree Analysis/phylogeny/tree_unrooted_ITS_paired.qza \
  --o-rooted-tree Analysis/phylogeny/tree_rooted_ITS_paired.qza