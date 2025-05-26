FROM ${FDEV_CAAS_REGISTRY}/${FDEV_CAAS_BASE_NAMESPACE}/ebank-centos-openjdk-tomcat-tftp:1.8-191_8.5.43_pro
MAINTAINER T-may "T-may@spdbdev.com"
ENV APP_DELIVERY_NAME pmclient.war
WORKDIR /ebank
RUN cd $TOMCAT_HOME && rm -rf webapps
COPY catalina.properties server.xml $TOMCAT_HOME/conf/
COPY catalina.sh $TOMCAT_HOME/bin/
RUN chmod +x $TOMCAT_HOME/bin/catalina.sh
COPY setEnv.sh /ebank
COPY pmclient.war $TOMCAT_HOME/webapps/
CMD ["sh","-c","/ebank/start.sh"]
