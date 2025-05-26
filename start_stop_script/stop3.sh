##################################  
#通用启停脚本
#david  
###################################

APP_NAME=managenode

psid=0
checkpid() {
   managenodePid=`ps -ef | grep $APP_NAME | grep -v grep | awk '{print $2}'`
   if [[ -n "$managenodePid" ]]; then 
      psid=$managenodePid
   else
      psid=0
   fi
}

status() {  
   checkpid  
   if [[ $psid -ne 0 ]];  then  
      echo "$APP_NAME is running! (pid=$psid)"  
   else  
      echo "$APP_NAME is not running"  
   fi  
}

start() { 
   checkpid  
   if [[ $psid -ne 0 ]]; then  
      echo "================================"  
      echo "warn: $APP_NAME already started! (pid=$psid)"  
      echo "================================"  
   else  
      echo -n "Starting $APP_NAME ..."  
      java -jar -Dspring.profiles.active=dev $APP_NAME-0.0.1-SNAPSHOT.jar > managenode_log.out &    
      checkpid  
      if [[ $psid -ne 0 ]]; then  
         echo "(pid=$psid) [OK]"  
      else  
         echo "[Failed]"  
      fi  
   fi
}  

stop() {  
   checkpid  
   if [[ $psid -ne 0 ]]; then  
      echo -n "Stopping $APP_NAME ...(pid=$psid) "  
      kill -9 $psid
      sleep 1
      if [[ $? -eq 0 ]]; then  
         echo "[OK]"  
      else  
         echo "[Failed]"  
      fi  
      checkpid  
      if [[ $psid -ne 0 ]]; then  
         stop  
      fi  
   else  
      echo "================================"  
      echo "warn: $APP_NAME is not running"  
      echo "================================"  
   fi  
}

###################################  
#读取脚本的第一个参数($1)，进行判断  
#参数取值范围：{start|stop|restart|status|info}  
#如参数不在指定范围之内，则打印帮助信息  
###################################  
case "$1" in  
   'start')  
      start  
      ;;  
   'stop')  
     stop  
     ;;  
   'restart')  
     stop  
     start  
     ;;  
   'status')  
     status  
     ;;  
  *)  
echo "Usage: $0 {start|stop|restart|status}"  
exit 1  
esac   
exit 0

转载于:https://my.oschina.net/ghw/blog/1619604

