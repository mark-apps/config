#!/bin/bash
./support-files/mysql.server start
ps -ef|grep /usr/local/mysql|grep -v grep
