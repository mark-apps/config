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
vim /etc/ssh/sshd_config
```
2.查看是否有“PermitRootLogin yes”，没有添加即可，完成后保存退出
3.UsePAM yes 更改为 UsePAM no (因为linux系统默认是使用pam管理登录的，使用ssh的配置更为方便)




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

