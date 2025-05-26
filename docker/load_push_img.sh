#!/bin/bash
echo "load images...."
docker load -i spdb_cep_mcli_rightapp_img_20200114_1.tar.gz
docker load -i spdb_cep_mcli_rightapppuservice_img_20200114_1.tar.gz
docker load -i spdb_cep_mcli_rightapploginservice_img_20200114_1.tar.gz
docker load -i spdb_cep_mcli_rightappmyservice_img_20200114_1.tar.gz
echo "load image finish."

echo "tag images..."
docker tag 10.134.34.228/cepp/cep-mcli-rightapp:pro-20200114-001 172.16.141.246/cepp/cep-mcli-rightapp:20200114-20200110125600
docker tag 10.134.34.228/cepp/cep-mcli-rightapppuservice:pro-20200114-001 172.16.141.246/cepp/cep-mcli-rightapppuservice:20200114-20200110125600
docker tag 10.134.34.228/cepp/cep-mcli-rightapploginservice:pro-20200114-001 172.16.141.246/cepp/cep-mcli-rightapploginservice:20200114-20200110125600
docker tag 10.134.34.228/cepp/cep-mcli-rightappmyservice:pro-20200114-001 172.16.141.246/cepp/cep-mcli-rightappmyservice:20200114-20200110125600
echo "tag images finish."

docker images|grep cep-mcli-rightapp|grep 20200114-20200110125600|grep 172.16.141.246
echo "docker login 172.16.141.246,Please input Username and Password..."


while true
do
docker login 172.16.141.246
if [[ $? -eq 0 ]]; then
break
else
echo "Login Failed, Please Relogin!"
fi
done


echo "push images...."
docker push 172.16.141.246/cepp/cep-mcli-rightapp:20200114-20200110125600
docker push 172.16.141.246/cepp/cep-mcli-rightapppuservice:20200114-20200110125600
docker push 172.16.141.246/cepp/cep-mcli-rightapploginservice:20200114-20200110125600
docker push 172.16.141.246/cepp/cep-mcli-rightappmyservice:20200114-20200110125600
echo "push image finish."
echo "please log on to the Caas platform to update the images."
