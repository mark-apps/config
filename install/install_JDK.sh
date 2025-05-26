#!/bin/bash
mkdir /usr/java

# 登录oracle官网下载JDK 
# https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
cd /usr/local/src


tar -zxvf jdk-8u281-linux-x64.tar.gz -C /usr/java/

#添加JAVA环境变量
#export JAVA_HOME=/usr/java/jdk1.8.0_181
#export JRE_HOME=/usr/java/jdk1.8.0_181/jre
#export CLASSPATH=.:/usr/java/jdk1.8.0_181/lib:/usr/java/jdk1.8.0_181/jre/lib
#export PATH=/usr/java/jdk1.8.0_181/bin:$PATH


#或者执行
echo "export JAVA_HOME=/usr/java/jdk1.8.0_281" >> /etc/profile \
&& echo "export JRE_HOME=/usr/java/jdk1.8.0_281/jre" >> /etc/profile \
&& echo "export CLASSPATH=.:/usr/java/jdk1.8.0_281/lib:/usr/java/jdk1.8.0_281/jre/lib" >> /etc/profile \
&& echo "export PATH=/usr/java/jdk1.8.0_281/bin:\$PATH" >> /etc/profile


source /etc/profile

echo "JDK install completed!" 
