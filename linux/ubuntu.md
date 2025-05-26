
### 常用安装包安装

```shell
apt install build-essential gcc g++ wget curl unzip vim telnet net-tools inetutils-ping jq lrzsz
apt install jq lrzsz git vim procps
apt update 
```

+ 安装Redis
```shell
apt install redis  （安装后配置文件在 /etc/redis/redis.conf）
```

+ 安装OpenJdk（Jre）
```shell
##安装 jdk（headless为无头版本）
apt install openjdk-8-jdk  或 apt install -y openjdk-8-jdk-headless
#安装 jre （headless为无头版本） 
apt install -y openjdk-8-jre 或 apt install -y openjdk-8-jre-headless
```
 
+ 安装docker
```shell
apt install -y nmon docker.io
````

+ 安装python
```shell
apt install -y python3 
```

+ 安装 nginx
```shell
apt install -y nginx   

nginx文件安装完成之后的文件位置：
+ /usr/sbin/nginx：主程序
+ /etc/nginx：存放配置文件
+ /usr/share/nginx：存放静态文件
+ /var/log/nginx：存放日志

启动 nginx：  
service start nginx
```

+ 安装go
```shell
##下载安装包（https://golang.google.cn/dl/）
wget https://golang.google.cn/dl/go1.18.3.linux-amd64.tar.gz  -O /tmp/go.tar.gz
tar -zxvf /temp/go.tar.gz -C /usr/local

##配置环境变量 （/etc/profile）
export GOROOT=/usr/local/go
export GOPATH=/root/go
export GOPROXY=https://goproxy.io,direct
export PATH=$PATH:$GOROOT/bin:$GOPTH/bin
```

+ 安装nodejs
```
##下载安装包 (http://nodejs.cn/download/)
wget https://npmmirror.com/mirrors/node/v16.15.1/node-v16.15.1-linux-x64.tar.xz -O /tmp/node.tar.xz
tar -zxvf /tmp/node.tar.xz -O /tmp/ && mv /tmp/node-v* /usr/local/node

##配置环境变量 （/etc/profile）
NODE_HOME=/usr/local/node
export PATH=$PATH:$NODE_HOME/bin
```


### Ubuntu 20.04换国内源 

```shell
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
```

### Ubuntu18.04更换国内源
```shell
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```


# Ubuntu 安装配置SSH服务

#### 安装ssh工具

 1.打开终端键入如下命令：

```bash
apt-get update
apt-get install openssh-server
```

####  启动SSH 服务

```shell
sudo /etc/init.d/ssh start
```

>  注：重启命令与关闭命令如下：
>  /etc/init.d/ssh restart   #重启SSH服务
>  /etc/init.d/ssh stop      #关闭SSH服务


查看进程，检查是否启动成功，键入如下命令：

```	shell
ps -e | grep sshd
```

有了进程才能进行SSH服务的使用。
- 配置root用户SSH服务
Ubuntu中SSH服务安装完成后查看是否允许root用户登陆，若不允许则无法远程登陆root用户，需要修改配置
1.首先，打开“/etc/ssh/sshd_config”
```bash
gedit /etc/ssh/sshd_config
```
2.查看是否有“PermitRootLogin yes”，没有添加即可，完成后保存退出




#### ubuntu开启22端口

虽然可以用命令 systemctl disable firewalld 直接关闭防火墙，但不建议这样做，推荐仅允许22端口通过防火墙：

```shell
# 若 firewalld 未安装，则先进行安装
sudo apt install firewalld
# 允许 tcp 22端口
sudo firewall-cmd --permanent --add-port=22/tcp
# 可选：允许ssh服务 
sudo firewall-cmd --permanent  --add-service=ssh
# reload 防火墙，应用规则
sudo systemctl reload firewalld
12345678
```

验证22端口是否开启：

```shell
sudo firewall-cmd --list-all
```

若结果中含有22端口表示开启。



#### 远程SSH登陆

最后就是登陆啦，在宿主机或同网段其它计算中，用命令行或各类SSH客户端（如Putty）登陆即可。







#### SSH 客户端安装
```shell
#安装 ssh 客户端
apt-get install ssh
#如果安装失败，则使用下面命令进行安装
apt-get install openssh-client
```


