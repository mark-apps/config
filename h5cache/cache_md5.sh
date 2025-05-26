#!/bin/sh

function clear_cache() {
	if test -f $1".version" ;then
		`rm -rf $1".version"`
	fi
	if test -f $1".info" ;then
		`rm -rf $1".info"`
	fi
}

function echo_md5 () {
	for file in `ls $1`
	do
		if test -d $1"/"$file ; then
			echo_md5 $1"/"$file $2 $3"/"$file;
		elif [ -f $1"/"$file ]; then
			if test ${file##*.}x = 'ttf'x ; then
				echo "filter "$3"/"$file;
				continue;
			fi;
			filename=$2$3"/"$file;
			echo "$filename=`md5sum $1"/"$file | cut -d " " -f1`" >> $2".info";
		fi
	done
}

function md5_info () {
	md5info=$1".info"
	echo "`md5sum $md5info | cut -d " " -f1`" >> $1".version"
}

clear_cache $2
echo_md5 $1 $2
#md5_info $2