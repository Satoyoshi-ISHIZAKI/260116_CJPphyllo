#!/bin/bash
awk '{print $3 " " $1}' 20260115_HN00265605_TAG_Report/assets/spgs/HN00265605_132samples_md5sum_DownloadLink.txt | grep -v File > md5sum.txt
