###  一、下载安装
+ **下载地址：** https://maven.apache.org/download.cgi
```
wget https://ftp.wayne.edu/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
tar -zxvf apache-maven-3.8.1-bin.tar.gz -C /usr/local/
```

###  二、配置环境变量
```
export MAVEN_HOME=/usr/local/apache-maven-3.8.1
export PATH=$PATH:${MAVEN_HOME}/bin
wget https://gitee.com/mayong82/config/raw/master/maven/settings-aliyun.xml -O  ${HOME}/.m2/settings.xml
```