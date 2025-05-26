### 查看下防火墙的状态：  
systemctl status firewalld  


### 开启防火墙   
systemctl start firewalld.service  


### 查看已开放的端口  
firewall-cmd --zone=public --list-ports        


### 添加端口到白名单
firewall-cmd --permanent --zone=public --add-port=8484/tcp  

### 命令含义
+ --zone #作用域  
+ --add-port=8484/tcp #添加端口，格式为：端口/通讯协议  
+ --permanent #永久生效，没有此参数重启后失效  


### 重启防火墙：添加成功之后需要重启防火墙  
firewall-cmd --reload  

