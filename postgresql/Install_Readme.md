#!/bin/bash

# 1、初始化数据库
./bin/initdb /data/postgresql/db -E utf8

# 2、创建日志目录
mkdir /data/postgresql/logs

# 3、启动数据库
./bin/pg_ctl -D /data/postgresql/db -l /data/postgresql/logs/server.log start

# 4、创建用户
./bin/createuser postgres -P

#5、创建数据库
./bin/createdb postgres -O postgres -E UTF8 -e

