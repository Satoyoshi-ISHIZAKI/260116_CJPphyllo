# merge rep-seqs and tables
# merging needs outputs from dada2 with exactly the same parameters

## Workflow to this file: 
## 1. qiime2_install.sh
## 2. make_manifest.sh
## 3. import.sh
## 4. trim.sh
## 5. dada2_16S.sh, dada2_ITS.sh, dada2_ITS_2306.sh
## 6. merge.sh (this file)

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash

# mkdir Analysis/merge

qiime feature-table merge \
  --i-tables Analysis/denoised/table_16S.qza Analysis/denoised/231202/table_16S.qza \
  --o-merged-table Analysis/merge/table_16S_mg.qza

qiime feature-table merge-seqs \
  --i-data Analysis/denoised/rep-seqs_16S.qza Analysis/denoised/231202/rep-seqs_16S.qza \
  --o-merged-data Analysis/merge/seq_16S_mg.qza

#ITS
qiime feature-table merge \
  --i-tables Analysis/denoised/table_ITS.qza Analysis/denoised/231202/table_ITS_single.qza \
  --o-merged-table Analysis/merge/table_ITS_mg.qza

qiime feature-table merge-seqs \
  --i-data Analysis/denoised/rep-seqs_ITS.qza Analysis/denoised/231202/rep-seqs_ITS_single.qza \
  --o-merged-data Analysis/merge/seq_ITS_mg.qza

## paired reads for ITS
qiime feature-table merge \
  --i-tables Analysis/denoised/table_ITS_paired.qza Analysis/denoised/231202/table_ITS_paired.qza \
  --o-merged-table Analysis/merge/table_ITS_paired_mg.qza

qiime feature-table merge-seqs \
  --i-data Analysis/denoised/rep-seqs_ITS_paired.qza Analysis/denoised/231202/rep-seqs_ITS_paired.qza \
  --o-merged-data Analysis/merge/seq_ITS_paired_mg.qza