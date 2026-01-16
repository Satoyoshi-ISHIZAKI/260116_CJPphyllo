#QC and inference of ASVs

##start docker container first
#docker start qiime2.2024.02
#docker exec -i -t qiime2.2024.02 /bin/bash

#change directory to your project folder beforehead

#make directory
#mkdir Analysis/denoised

#perform QC and denoising using only forward reads
##modify length to be trimmed and truncated according to your data quality
qiime dada2 denoise-single \
  --i-demultiplexed-seqs Analysis/demux/trimmed_paired-end_ITS.qza \
  --p-trim-left 0 \
  --p-trunc-len 246 \
  --p-n-threads 0 \
  --o-representative-sequences Analysis/denoised/rep-seqs_ITS.qza \
  --o-table Analysis/denoised/table_ITS.qza \
  --o-denoising-stats Analysis/denoised/denoising-stats_ITS.qza

qiime feature-table summarize \
    --i-table Analysis/denoised/table_ITS.qza \
    --o-visualization Analysis/denoised/table_ITS.qzv

qiime feature-table tabulate-seqs \
    --i-data Analysis/denoised/rep-seqs_ITS.qza \
    --o-visualization Analysis/denoised/rep-seqs_ITS.qzv

#stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/denoising-stats_ITS.qza \
    --o-visualization Analysis/denoised/denoising-stats_ITS.qzv

qiime tools export \
    --input-path Analysis/denoised/denoising-stats_ITS.qza \
    --output-path Analysis/denoised/dada2_output_ITS
