#!/bin/bash

#判断操作系统类型，安装c 和 c++ 编译器
#radhat或centos存在： /etc/redhat-release 这个文件【 命令 cat /etc/redhat-release 】
#ubuntu存在 : /etc/lsb-release 这个文件 【命令 cat /etc/lsb-release 】
if [ -f /etc/redhat-release ]; then
	yum -y install gcc gcc-c++ make automake
	yum -y install net-tools vim wget curl unzip
elif [ -f /etc/lsb-release ]; then
	sudo apt update
	sudo apt install -y build-essential gcc g++ make automake
	sudo apt install -y net-tools vim wget curl unzip
else
  echo "Unsupport operator system."
  exit
fi

##源码目录
SRC_DIR=/usr/local/src
#安装位置
INSTLL_DIR=/usr/local


##下载软件
cd $SRC_DIR

##源下载地址
[ ! -f pcre-8.43.tar.gz ] && wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz
[ ! -f zlib-1.2.11.tar.gz ] && wget http://www.zlib.net/zlib-1.2.12.tar.gz
[ ! -f openssl-1.1.1d.tar.gz ] && wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1d.tar.gz
[ ! -f nginx-1.18.0.tar.gz ] && wget http://nginx.org/download/nginx-1.18.0.tar.gz

##自建的下载地址
# wget http://mydmz.cc:81/download/software/nginx/pcre-8.43.tar.gz
# wget http://mydmz.cc:81/download/software/nginx/zlib-1.2.11.tar.gz
# wget http://mydmz.cc:81/download/software/nginx/openssl-1.1.1d.tar.gz
# wget http://mydmz.cc:81/download/software/nginx/nginx-1.18.0.tar.gz


#安装 pcre
cd $SRC_DIR
echo  "start install pcre..."
rm -rf pcre-8.43
tar -zxvf pcre-8.43.tar.gz
cd pcre-8.43 && ./configure --prefix=$INSTLL_DIR/pcre && make && make install

echo "pcre instal complete."
echo "------------------------------------------------------"

#安装zlib
cd $SRC_DIR
echo "start install zlib..."
rm -rf zlib-1.2.11
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11 && ./configure --prefix=$INSTLL_DIR/zlib && make && make install

echo "zlib install complete."
echo "------------------------------------------------------"


##安装 openssh
cd $SRC_DIR
echo "start install openssl..."
rm -rf openssl-1.1.1d
tar -zxvf openssl-1.1.1d.tar.gz
cd openssl-1.1.1d && ./config --prefix=$INSTLL_DIR/openssl && make && make install
echo "openssl install complete."
echo "------------------------------------------------------"


##安装 nginx
cd $SRC_DIR
echo "start install nginx...."
rm -rf nginx-1.18.0
tar -zxvf nginx-1.18.0.tar.gz
cd nginx-1.18.0
#解决openssl报错问题
sed -i 's/\.openssl\///g' auto/lib/openssl/conf

##简单配置版
./configure \
--prefix=$INSTLL_DIR/nginx \
--with-pcre=../pcre-8.43 \
--with-zlib=../zlib-1.2.11 \
--with-openssl=$INSTLL_DIR/openssl \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_slice_module \
--with-http_mp4_module \
--with-stream

make && make install
echo "nginx install complete!"
