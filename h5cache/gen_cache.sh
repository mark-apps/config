#!/bin/bash
#read -p "请输入服务名称[示例：xxxx] :" p1
#if [[ -z $p1 ]]; then
SERVER_IP='http://xxxx:8000/h5cache'
p1=`echo $(hostname)|cut -d '-' -f 1-3`
#fi
projectName=$p1

##特殊项目名称转义
if [[ $p1 == 'xxxx' ]];then
projectName="bbb"
fi

echo "当前服务名称是: ${projectName}"
cd /tmp/ && mkdir h5cache
echo "正在准备环境...."
curl ${SERVER_IP}/LinuxPackage/unzip.rpm -o unzip.rpm
curl ${SERVER_IP}/LinuxPackage/wget.rpm -o wget.rpm
curl ${SERVER_IP}/LinuxPackage/ftp.rpm -o ftp.rpm
rpm -ivh unzip.rpm
rpm -ivh wget.rpm
rpm -ivh ftp.rpm
rm -f *.rpm
echo "环境准备完毕。"

cd /tmp/
[ -d /tmp/h5cache ] && rm -rf /tmp/h5cache
mkdir h5cache

echo "正载下载genemd5.sh脚本...."
wget ${SERVER_IP}/genemd5.sh
###不同项目不同处理
if [[ $projectName == 'bbb' ]]
then
	##只解压mpage目录，并且排除mpage下的styles，scripts，spdbstyles目录
	unzip -o /usr/local/tomcat/webapps/bbb.war "mpage/*" -x "mpage/bbb-data/styles/*" "mpage/bbb-data/scripts/*" "mpage/bbb-data/styles/*" -d bbb
	sh genemd5.sh bbb bbb
	echo "缓存文件生成完成...."
	cat bbb.info > /usr/local/tomcat/webapps/bbb.info
	cat bbb.version > /usr/local/tomcat/webapps/bbb.version
else
	unzip -oq /ebank/vue.war -d vue
	sh genemd5.sh vue/WEB-INF/classes/static ${projectName}
	echo "缓存文件生成完成...."
	cat ${projectName}.info > /temp/${projectName}.info
	cat ${projectName}.version > /temp/${projectName}.version
	echo "已复制缓存文件${projectName}.info ${projectName}.version到/ebank目录下."
fi
##下载ftp文件上传脚本
echo "正载下载upload.sh脚本...."
wget ${SERVER_IP}/upload.sh

##FTP 参数配置
ftp_host=xx.xx.xx.xx
ftp_port=21
ftp_user=ftp
ftp_passwd=ftp1234
ftp_remoteDir=/h5cache/prod/
ftp_localDir=`pwd`
##调用ftp上传脚本上传缓存文件到指定位置
echo "正在上传FTP服务器...."
sh upload.sh ${ftp_host} ${ftp_port} ${ftp_user} ${ftp_passwd} ${ftp_remoteDir} ${ftp_localDir} ${projectName}.info
echo "缓存文件已上传FTP服务器${ftp_host}:${ftp_remoteDir}${projectName}.info"

echo "正在清理临时文件...."
cd /tmp/ && rm -rf h5cache
echo "清理临时文件完成"
echo "-----end-----"

### 调用方式
### curl -fsSL http://${SERVER_IP}/h5cache/gen_cache_prod.sh|bash
###	or
### curl http://${SERVER_IP}/h5cache/gen_cache_prod.sh -o gen_cache.sh
### sh gen_cache.sh
### 然后按照提示完成即可。

