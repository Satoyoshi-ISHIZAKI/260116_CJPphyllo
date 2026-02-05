# install q2-feature-classifier plugin
# https://docs.qiime2.org/2024.2/plugins/available/feature-classifier/
# https://docs.qiime2.org/2024.2/tutorials/classifier/

## Workflow to this file:
## 1. qiime2_install.sh
## 2. classifier_install.sh (this file)
## 3. make_manifest.sh
## 4. import.sh
## 5. trim.sh
## 6. dada2_16S.sh / dada2_ITS.sh
## 7. merge.sh
## 8. filter_singltons.sh

## start docker container first
# docker start qiime2.(version)
# docker exec -i -t qiime2.(version) /bin/bash
# change directory to your project folder beforehand
# mkdir classifiers

# Silva classifier
# download pre-trained classifier for 16S rRNA gene sequences (Silva 138, 99% OTUs, diverse-weighted)
# see https://library.qiime2.org/data-resources#qiime-2-2024-5-present
wget https://data.qiime2.org/classifiers/sklearn-1.4.2/silva/silva-138-99-nb-diverse-weighted-classifier.qza -O classifiers/silva-138-99-nb-diverse-weighted-classifier.qza

# UNITE classifier
