## 常用软件包安装
sudo apt install build-essential gcc g++ make
> build-essential is a meta-package in Debian and Ubuntu that provides the essential tools for compiling software from source code. It includes packages like gcc, g++, make, and libc, which are necessary for building most software on a Debian/Ubuntu system
> 

sudo apt install curl wget jq net-tools git vim


## 安装systemctl
apt install systemctl
##验证
systemctl status
systemctl list-unit-files

##journalctl
apt install systemd

##SSH服务器
##作用:允许通过SSH协议远程登录和管理服务器。
##安装命令:sudo apt-get install openssh-server﻿

##NFS客户端:
作用:允许挂载并访问NFS共享的目录。
安装命令:sudo apt-get install nfs-common﻿

##Git:
作用:版本控制系统，用于代码管理和协作开发。
安装命令:sudo apt-get install git﻿

安装cifs挂载工具（mount）
sudo apt-get install cifs-utils
