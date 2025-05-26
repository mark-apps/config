## CentOS 7更换镜像源

1、打开阿里镜像：https://developer.aliyun.com/mirror/

2、下载新的 CentOS-Base.repo 到 /etc/yum.repos.d/
```shell
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
或者
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
```

3、更新镜像源。
```shell
#清除缓存
yum clean all
#生成缓存
yum makecache
```


## CentOS 8 修改镜像源

+ 阿里镜像源
```shell
wget http://mirrors.aliyun.com/repo/Centos-8.repo
```

+ 华为镜像源
```shell
wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-8-reg.repo
```

清除和刷新yum缓存
```shell
#清理缓存
yum clean all

#刷新缓存
执行yum makecache 或者 yum repolist all
```
