#!/bin/bash
IMAGE_IP=10.134.34.228
IMAGE_NS=cepp
IMAGE_TAG=pro-20200114-001
SAVE_NAME=20200114_1
echo "export cep-mcli-rightapp...."
docker save $IMAGE_IP/$IMAGE_NS/cep-mcli-rightapp:$IMAGE_TAG -o spdb_cep_mcli_rightapp_img_${SAVE_NAME}.tar
echo "export cep-mcli-rightapppuservice..."
docker save $IMAGE_IP/$IMAGE_NS/cep-mcli-rightapppuservice:$IMAGE_TAG -o spdb_cep_mcli_rightapppuservice_img_${SAVE_NAME}.tar
echo "export cep-mcli-rightapprightservice...."
docker save $IMAGE_IP/$IMAGE_NS/cep-mcli-rightapprightservice:$IMAGE_TAG -o spdb_cep_mcli_rightapprightservice_img_${SAVE_NAME}.tar
echo "export cep-mcli-rightapploginservice...."
docker save $IMAGE_IP/$IMAGE_NS/cep-mcli-rightapploginservice:$IMAGE_TAG -o spdb_cep_mcli_rightapploginservice_img_${SAVE_NAME}.tar
echo "export cep-mcli-rightappmyservice...."
docker save $IMAGE_IP/$IMAGE_NS/cep-mcli-rightappmyservice:$IMAGE_TAG -o spdb_cep_mcli_rightappmyservice_img_${SAVE_NAME}.tar

echo "gzip spdb_cep_mcli_rightapp_img_${SAVE_NAME}.tar..."
gzip spdb_cep_mcli_rightapp_img_${SAVE_NAME}.tar
echo "gzip spdb_cep_mcli_rightapppuservice_img_${SAVE_NAME}.tar..." 
gzip spdb_cep_mcli_rightapppuservice_img_${SAVE_NAME}.tar
echo "gzip spdb_cep_mcli_rightapprightservice_img_${SAVE_NAME}.tar..."
gzip spdb_cep_mcli_rightapprightservice_img_${SAVE_NAME}.tar
echo "gzip spdb_cep_mcli_rightapploginservice_img_${SAVE_NAME}.tar..."
gzip spdb_cep_mcli_rightapploginservice_img_${SAVE_NAME}.tar
echo "gzip spdb_cep_mcli_rightappmyservice_img_${SAVE_NAME}.tar..."
gzip spdb_cep_mcli_rightappmyservice_img_${SAVE_NAME}.tar

echo "export docker images finish";
ls -lrth

