#QC and inference of ASVs

##start docker container first
#docker start qiime2.2024.02
#docker exec -i -t qiime2.2024.02 /bin/bash

#change directory to your project folder beforehead

#make directory
#mkdir Analysis/denoised

##modify length to be trimmed and truncated according to your data quality

##overlap should be > 20 (preferably > 100 ?)
##weaker quality filter

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs Analysis/demux/trimmed_paired-end_16S.qza \
  --p-trim-left-f 0 \
  --p-trim-left-r 0 \
  --p-trunc-len-f 250 \
  --p-trunc-len-r 180 \ #change this number suitable for the quality of your sequence data
  --p-n-threads 0 \
  --p-min-overlap 20 \
  --p-retain-all-samples True \
  --o-representative-sequences Analysis/denoised/rep-seqs_16S.qza \
  --o-table Analysis/denoised/table_16S.qza \
  --o-denoising-stats Analysis/denoised/denoising-stats_16S.qza

qiime feature-table summarize \
    --i-table Analysis/denoised/table_16S.qza \
    --o-visualization Analysis/denoised/table_16S.qzv

qiime feature-table tabulate-seqs \
    --i-data Analysis/denoised/rep-seqs_16S.qza \
    --o-visualization Analysis/denoised/rep-seqs_16S.qzv

#stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/denoising-stats_16S.qza \
    --o-visualization Analysis/denoised/denoising-stats_16S.qzv

qiime tools export \
    --input-path Analysis/denoised/denoising-stats_16S.qza \
    --output-path Analysis/denoised/dada2_output_16S

#modify some options since large proportion of sequences was filtered
#longer trim length
qiime dada2 denoise-paired \
  --i-demultiplexed-seqs Analysis/demux/trimmed_paired-end_16S.qza \
  --p-trim-left-f 0 \
  --p-trim-left-r 0 \
  --p-trunc-len-f 220 \
  --p-trunc-len-r 135 \
  --p-n-threads 0 \
  --p-min-overlap 20 \
  --p-retain-all-samples True \
  --o-representative-sequences Analysis/denoised/rep-seqs_16S_tr.qza \
  --o-table Analysis/denoised/table_16S_tr.qza \
  --o-denoising-stats Analysis/denoised/denoising-stats_16S_tr.qza

  #stats visualization
qiime metadata tabulate \
    --m-input-file Analysis/denoised/denoising-stats_16S_tr.qza \
    --o-visualization Analysis/denoised/denoising-stats_16S_tr.qzv

qiime tools export \
    --input-path Analysis/denoised/denoising-stats_16S_tr.qza \
    --output-path Analysis/denoised/dada2_output_16S_tr

#don't change the threshold for the expected error rates because it will not drastically improve the numbers of merged reads
#only a small propotion (~10%) of the reads in the putative contaminated samples is 16S sequences