##################################################################################
## Version： 2.0                                                                ##
## Date： 2020-07-22                                                            ##
## Description：静态资源缓存生成工具                                               ##
## 参数说明： $1 静态资源目录  $2 服务上下文（同时也是缓存文件名）                      ##
## 示例：sh genemd5.sh src/main/resources/static                                ##
#################################################################################

#!/bin/sh
function clear_cache() {
	if [ -f $1".version" ];then
		rm -f $1".version"
	fi
	if [ -f $1".info" ];then
		rm -f $1".info"
	fi
}

function echo_md5 () {
	for file in `ls $1`
	do
		if [ -d $1"/"$file ]; then
			echo_md5 $1/$file $2 $3/$file
		elif [ -f $1/$file ]; then
			fileExt=${file##*.}
			if [[ -n $fileExt ]] && [[ "ttf|woff|woff2|eot|map|gz|mp3|mp4|pdf|info|version" == *$fileExt* ]]; then
			   echo "filter file: $3/$file"
			   continue
			fi
			fileName=$2$3/$file
			fileMd5=`md5sum $1/$file|cut -d " " -f1`
			echo "$fileName=$fileMd5" >> $2".info"
		fi
	done
}

function md5_info () {
	infofile=$1".info"
	echo "`md5sum $infofile | cut -d " " -f1`" >> $1".version"
}

clear_cache $2
echo_md5 $1 $2
md5_info $2

