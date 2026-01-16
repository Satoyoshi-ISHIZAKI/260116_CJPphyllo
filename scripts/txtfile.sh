#!/bin/bash
awk '{print $3 " " $1}' report/20241118_JN00018944_MSS_Report/assets/spgs/JN00018944_192samples_md5sum_DownloadLink.txt | grep -v File > md5sum.txt
