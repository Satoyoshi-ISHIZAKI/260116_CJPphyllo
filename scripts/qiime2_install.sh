# Check the latest version at https://docs.qiime2.org/
docker pull quay.io/qiime2/amplicon:2026.1
docker run -i -t --name qiime2.2026.1 -v $(pwd):/data quay.io/qiime2/amplicon:2026.1 /bin/bash