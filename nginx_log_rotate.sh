#!/bin/bash
#日志存储路径
logs_backup_path="/ebank/nginx/logs/$(date +%Y-%m-%d)"
#要切割的日志路径
logs_path="/ebank/nginx/logs"
#要切割的日志
logs_access="access"
logs_error="error"

##nginx pid
pid_path=/ebank/nginx/logs/nginx.pid

[ -d $logs_backup_path ] || mkdir -p $logs_backup_path
suffix=$(date "+%Y%m%d%H%M%S")
cd ${logs_path}
for log in `ls *.log`
do
  echo "current rotate log file: ${log}"
   mv ${logs_path}/${log} ${logs_backup_path}/${log%.*}_${suffix}.log
done

#告诉 nginx 重新加载配置以生成新的日志文件
kill -USR1 $(cat $pid_path)


