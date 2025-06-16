## 常用软件包安装
sudo apt install build-essential gcc g++ make
> build-essential is a meta-package in Debian and Ubuntu that provides the essential tools for compiling software from source code. It includes packages like gcc, g++, make, and libc, which are necessary for building most software on a Debian/Ubuntu system
> 

sudo apt install curl wget jq net-tools git vim nmon lrzdz trzsz


## 安装systemctl
apt install systemctl
##验证
systemctl status
systemctl list-unit-files

##journalctl
apt install systemd

##SSH服务器
```bash
apt install openssh-server
```

##NFS客户端
```bash
apt install nfs-common﻿
```

##Git:
```bash
apt install git﻿
```

安装cifs挂载工具（mount）
```bash
apt install cifs-utils
```

