## vim /etc/docker/daemon.json  
```json
{
  "data-root":"/docker",
  "bip":"192.168.100.1/24",
  "registry-mirrors": ["https://gyvdwe4d.mirror.aliyuncs.com"],
  "log-driver":"json-file",
  "log-opts": {"max-size":"500m", "max-file":"3"}
}

```
+ bip 网络分配的ip段
+ registry-mirrors 为镜像地址，这里配置的是阿里云的镜像加速器地址(注册阿里云账户号每个用户都有)
+ max-size=500m，意味着一个容器日志大小上限是500M，  
+ max-file=3，意味着一个容器有三个日志，分别是id+.json、id+1.json、id+2.json  
注：设置后只对新添加的容器有效。  
重启docker守护进程  
```shell
systemctl daemon-reload
systemctl restart docker
```



### 阿里云镜像加速器： https://gyvdwe4d.mirror.aliyuncs.com  

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "data-root":"/docker",
  "bip":"192.168.100.1/24",
  "registry-mirrors": ["http://f613ce8f.m.daocloud.io"],
  "log-driver":"json-file",
  "log-opts": {"max-size":"500m", "max-file":"3"}
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```


