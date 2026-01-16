#merge rep-seqs and tables
#merging needs outputs from dada2 with exactly the same parameters

##start docker container first
#docker start qiime2.2024.02
#docker exec -i -t qiime2.2024.02 /bin/bash

#mkdir 241120_phyllo/Analysis/merge

qiime feature-table merge \
  --i-tables 231202_Sugi_phyllosphere_June/Analysis/denoised/table_16S_tr.qza \
  --i-tables 241120_phyllo/Analysis/denoised/table_16S_tr.qza \
  --o-merged-table 241120_phyllo/Analysis/merge/table_merge2324_16S.qza

qiime feature-table merge-seqs \
  --i-data 231202_Sugi_phyllosphere_June/Analysis/denoised/rep-seqs_16S_tr.qza \
  --i-data 241120_phyllo/Analysis/denoised/rep-seqs_16S_tr.qza \
  --o-merged-data 241120_phyllo/Analysis/merge/seq_merge2324_16S.qza

#ITS
qiime feature-table merge \
  --i-tables 231202_Sugi_phyllosphere_June/Analysis/denoised/table_ITS_tr.qza \
  --i-tables 241120_phyllo/Analysis/denoised/table_ITS.qza \
  --o-merged-table 241120_phyllo/Analysis/merge/table_merge2324_ITS.qza

qiime feature-table merge-seqs \
  --i-data 231202_Sugi_phyllosphere_June/Analysis/denoised/rep-seqs_ITS_tr.qza \
  --i-data 241120_phyllo/Analysis/denoised/rep-seqs_ITS.qza \
  --o-merged-data 241120_phyllo/Analysis/merge/seq_merge2324_ITS.qza