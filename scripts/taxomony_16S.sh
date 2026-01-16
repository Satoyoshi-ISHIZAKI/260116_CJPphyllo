#assign taxonomy to ASVs

##start docker container first
#docker start qiime2.2024.10
#docker exec -i -t qiime2.2024.10 /bin/bash

#change directory to your project folder beforehead

#make directory
#mkdir Analysis/taxa

#used SILVA database and scikit-learn feature-classifier
#cite:
#Bokulich et al. (2018). Optimizing taxonomic classification of marker-gene amplicon sequences with QIIME 2’s q2-feature-classifier plugin.
#Quast et al. (2012). The SILVA ribosomal RNA gene database project: improved data processing and web-based tools.
#Robeson et al. (2021). RESCRIPt: reproducible sequence taxonomy reference database management.

#train a naive bayes classifier
#do in a PC with a large computational power
qiime feature-classifier fit-classifier-naive-bayes \
    --i-reference-reads /data/SILVA_202410/silva-138-99-seqs-515-806.qza \
    --i-reference-taxonomy /data/SILVA_202410/silva-138-99-tax-515-806.qza \
    --o-classifier /data/SILVA_202410/silva-138-99-515-806-classifier_2410.qza

qiime feature-classifier classify-sklearn \
    --i-reads Analysis/denoised/rep-seqs_16S.qza \
    --i-classifier /data/SILVA_202410/silva_2410_nb_classifier.qza \
    --o-classification Analysis/taxa/classification_16S.qza

#barplot
qiime taxa barplot \
    --i-table Analysis/denoised/table_16S.qza \
    --i-taxonomy Analysis/taxa/classification_16S.qza \
    --o-visualization Analysis/taxa/taxa_barplot_16S.qzv

#contami除去
#mkdir Analysis/NoContam

qiime taxa filter-table \
    --i-table Analysis/denoised/table_16S.qza \
    --i-taxonomy Analysis/taxa/classification_16S.qza \
    --p-exclude mitochondria,chloroplast,Unassigned,d__Eukaryota \
    --o-filtered-table Analysis/NoContam/table-no-contam_16S.qza

qiime taxa filter-seqs \
    --i-sequences Analysis/denoised/rep-seqs_16S.qza \
    --i-taxonomy Analysis/taxa/classification_16S.qza \
    --p-exclude mitochondria,chloroplast,Unassigned,d__Eukaryota \
    --o-filtered-sequences Analysis/NoContam/seq-no-contam_16S.qza

qiime feature-table tabulate-seqs \
    --i-data Analysis/NoContam/seq-no-contam_16S.qza \
    --o-visualization Analysis/NoContam/seq-no-contam_16S.qzv

qiime taxa barplot \
    --i-table Analysis/NoContam/table-no-contam_16S.qza \
    --i-taxonomy Analysis/taxa/classification_16S.qza \
    --o-visualization Analysis/NoContam/taxa_barplot_16S.qzv



#use reads with longer downstream cutoffs
qiime feature-classifier classify-sklearn \
    --i-reads Analysis/denoised/rep-seqs_16S_tr.qza \
    --i-classifier /data/SILVA_202410/silva_2410_nb_classifier.qza \
    --o-classification Analysis/taxa/classification_16S_tr.qza

#barplot
qiime taxa barplot \
    --i-table Analysis/denoised/table_16S_tr.qza \
    --i-taxonomy Analysis/taxa/classification_16S_tr.qza \
    --o-visualization Analysis/taxa/taxa_barplot_16S_tr.qzv

#contami除去
#mkdir Analysis/NoContam

qiime taxa filter-table \
    --i-table Analysis/denoised/table_16S_tr.qza \
    --i-taxonomy Analysis/taxa/classification_16S_tr.qza \
    --p-exclude mitochondria,chloroplast,Unassigned,d__Eukaryota \
    --p-include d__Bacteria \
    --o-filtered-table Analysis/NoContam/table-no-contam_16S_tr.qza

qiime taxa filter-seqs \
    --i-sequences Analysis/denoised/rep-seqs_16S_tr.qza \
    --i-taxonomy Analysis/taxa/classification_16S_tr.qza \
    --p-exclude mitochondria,chloroplast,Unassigned,d__Eukaryota \
    --p-include d__Bacteria \
    --o-filtered-sequences Analysis/NoContam/seq-no-contam_16S_tr.qza

qiime taxa barplot \
    --i-table Analysis/NoContam/table-no-contam_16S_tr.qza \
    --i-taxonomy Analysis/taxa/classification_16S_tr.qza \
    --o-visualization Analysis/NoContam/taxa_barplot_16S_tr.qzv