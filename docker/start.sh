sh setDockerEnv.sh
if [ -f "setEnv.sh" ] ; then
  source /ebank/setEnv.sh
fi

umask 0000

java -Xms2048m -Xmx2048m -XX:CICompilerCount=2 -XX:ParallelGCThreads=4  -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -Xloggc:/logs/`hostname`_gc.log.crn $JAVA_OPTIONS -Dspring.profiles.active=$spring_profiles_active -DSPRING_CLOUD_CONFIG_URI=$SPRING_CLOUD_CONFIG_URI -DEUREKA_CLIENT_SERVICEURL_DEFAULTZONE=$EUREKA_CLIENT_SERVICEURL_DEFAULTZONE -Dorg.apache.catalina.security.SecurityListener.UMASK=0000 -jar $APP_DELIVERY_NAME >> /logs/$HOSTNAME.out.log.crn 2>&1

