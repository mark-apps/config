#!/bin/bash

if [ "$1" = "" ] ; then
	if [ "${SERVER_NAME}" = "" ] ; then
        usage $0
        exit
	fi
else
    SERVER_NAME="$1"
    shift
fi

ps -ef|grep java|grep $SERVER_NAME' -'|awk '{print $2}'|while read pid
do
	kill $pid
done

sleep 1

rm -rf ../servers/${SERVER_NAME}/tmp
rm -rf ../servers/${SERVER_NAME}/cache
rm -rf ../servers/${SERVER_NAME}/data
rm -rf ../servers/${SERVER_NAME}/stage
