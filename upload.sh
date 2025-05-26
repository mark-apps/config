#!/bin/bash
filePath=$1
curl -F "file=@$filePath" "https://etest2.spdb.com.cn/pmclient/svt/UploadFile.shtml?fileDir=SWIFT"

