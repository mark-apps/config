#!/bin/bash
docker rmi -f $(docker images|grep mspmk-cli| awk '{print $3}')
docker rmi -f $(docker images|grep msliv-cli|grep -v pro | awk '{print $3}')
docker rmi -f $(docker images|grep cep-mcli| awk '{print $3}')
docker rmi -f $(docker images|grep sgoverseas-branch-ovsemb|grep -v pro | awk '{print $3}')
docker rmi -f $(docker images|grep hkoverseas-branch-ovsemb|grep -v pro | awk '{print $3}')
docker rmi -f $(docker images|grep sgoverseas-branch-ospmclient|grep -v pro | awk '{print $3}')
docker rmi -f $(docker images|grep hkoverseas-branch-ospmclient|grep -v pro | awk '{print $3}')
docker rmi -f $(docker images|grep spdb-cli-mobcli|awk '{print $3}')
docker rmi -f $(docker images|grep spdb-cli-cmnet|awk '{print $3}')
docker rmi -f $(docker images|grep spdb-cli-emclient|awk '{print $3}')
docker rmi -f $(docker images|grep spdb-cli-memclient|awk '{print $3}')
echo "image clean finish!"



docker rmi -f $(docker images|grep -v pro-20200116|grep -v ebank-centos|grep -v spdb-centos-jre-standard|awk '{print $3}')


docker images|grep -v pro-20200116|grep -v ebank-centos|grep -v spdb-centos-jre-standard