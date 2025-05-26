#!/bin/sh
if [ -n "$appPort" ];
then
sed -i "s/9092/${appPort}/g" $TOMCAT_HOME/conf/server.xml;
fi

mkdir -p /ebank/spdb/config

ip=`hostname -i`
DCE_SERVER_IP=`ifconfig  -a | grep inet | grep -v inet6 |grep 10| awk '{print $2}'`

export DCE_SERVER_IP=$DCE_SERVER_IP
COMMON_CONF_FILE=/ebank/spdb/params/config/mobcli/$COMMON_CONF_FILENAME
COMMON_LINK_FILE=/ebank/spdb/config/ebank_common_cli.properties
UNIQUE_CONF_FILE=/ebank/spdb/params/config/mobcli/$UNIQUE_CONF_FILENAME
UNIQUE_IP_CONF_FILE=/ebank/spdb/params/config/mobcli/$UNIQUE_CONF_FILENAME.$DCE_SERVER_IP
UNIQUE_LINK_FILE=/ebank/spdb/config/ebank_unique.properties

if [ -f "$COMMON_CONF_FILE" ]&&[ ! -f "$COMMON_LINK_FILE" ]
then
ln -s $COMMON_CONF_FILE $COMMON_LINK_FILE
fi

if [ -f "$UNIQUE_IP_CONF_FILE" ]&&[ ! -f "$UNIQUE_LINK_FILE" ]
then
 ln -s $UNIQUE_IP_CONF_FILE $UNIQUE_LINK_FILE
fi

if [ ! -f "$UNIQUE_IP_CONF_FILE" ]&&[ -f "$UNIQUE_CONF_FILE" ]&&[ ! -f "$UNIQUE_LINK_FILE" ]
then
 ln -s $UNIQUE_CONF_FILE $UNIQUE_LINK_FILE
fi

export UMASK="0000"
