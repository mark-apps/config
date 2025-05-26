场景
由于原镜像中的/etc/apt/sources.list文件使用的源较慢，需要修改为国内的阿里云。可通过以下命令写入：

RUN echo 'deb http://mirrors.aliyun.com/debian/ buster main non-free contrib\n\
deb http://mirrors.aliyun.com/debian-security buster/updates main\n\
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\n'\
> /etc/apt/sources.list
注意：

这里使用单引号'，所以无法使用诸如$(lsb_release -cs)的逻辑，如需使用，修改为双引号"
此处无法使用$(lsb_release -cs)获取版本号，因为一般镜像没有安装software-properties-common
如果想要在代码中实时获取真实的系统版本号（buster），需要使用以下命令：
cat /etc/os-release | grep "VERSION_CODENAME" | awk -F '=' '{print $2}'
修改后的实时获取真实系统版本号的代码如下：

RUN echo "deb http://mirrors.aliyun.com/debian/ $(cat /etc/os-release | grep "VERSION_CODENAME" | awk -F '=' '{print $2}') main non-free contrib\n\

deb http://mirrors.aliyun.com/debian-security $(cat /etc/os-release | grep "VERSION_CODENAME" | awk -F '=' '{print $2}')/updates main\n\

deb http://mirrors.aliyun.com/debian/ $(cat /etc/os-release | grep "VERSION_CODENAME" | awk -F '=' '{print $2}')-updates main non-free contrib\n\

deb http://mirrors.aliyun.com/debian/ $(cat /etc/os-release | grep "VERSION_CODENAME" | awk -F '=' '{print $2}')-backports main non-free contrib\n"\
> /etc/apt/sources.list
