FROM 10.134.34.228/ebank_base/ebank-centos-openjdk:1.8-191_pro
MAINTAINER may "T-may@spdbdev.com"
WORKDIR /opt/
COPY ftpserver.jar /opt/
COPY start.sh /opt/
RUN chmod +x start.sh
CMD ["sh","-c","/opt/start.sh"]
