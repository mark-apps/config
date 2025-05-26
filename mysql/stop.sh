#!/bin/bash
./support-files/mysql.server stop
sleep 3
ps -ef|grep /usr/local/mysql

