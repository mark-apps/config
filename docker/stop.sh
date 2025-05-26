ps -ef|grep java|grep $APP_DELIVERY_NAME |awk '{print $2}'|while read pid
do
   kill $pid
done
