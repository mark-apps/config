#!/bin/bash
REPOSITY=10.141.44.2
NAMESPACE=appent-sit1-tenant
NAME=spdb-cli-emclient
USER=ebank
PASSWD=ebank@spdb
echo 'Please input image version:(format:SIT-20190814-001):'
read ans
tmp_ans=$(echo $ans |tr [a-z] [A-Z])   ##将输入全部转成大写
if [[ $ans == "" ]] ; then
VERSION=SIT-`date +%Y%m%d-%H%M`
elif [[ $tmp_ans == "SIT" ]] || [[ $tmp_ans == "UAT" ]] || [[ $tmp_ans == "REL" ]] || [[ $tmp_ans == "YACE" ]]; then
VERSION=$tmp_ans-`date +%Y%m%d-%H%M`
else
VERSION=$ans
fi
echo "Image full name is:${REPOSITY}/${NAMESPACE}/${NAME}:${VERSION}"
docker build . -t ${REPOSITY}/${NAMESPACE}/${NAME}:${VERSION}
docker login ${REPOSITY} -u ${USER} -p ${PASSWD}
docker push ${REPOSITY}/${NAMESPACE}/${NAME}:${VERSION}
echo "Package Successful."
echo "Docker image is: ${REPOSITY}/${NAMESPACE}/${NAME}:${VERSION}"
