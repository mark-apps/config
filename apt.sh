apt update

apt install build-essential curl wget telnet net-tools inetutils-ping vim -y

apt install git cron screen jq nmon lrzsz -y

apt install openjdk-8-jre-headless


apt install software-properties-common ntp
sudo systemctl enable ntp && sudo systemctl start ntp



##Download go  
# https://golang.google.cn/dl/


##Download Nodejs
#  http://nodejs.cn/download/





# alias npm='npm --registry=https://registry.npm.taobao.org'

export GOROOT=/usr/local/go
export GOPATH=/root/go
export GOPROXY=https://goproxy.io,direct

export NODE_HOME=/usr/local/node-v16.3.0-linux-x64

export PATH=$PATH:/mayong/bin:/zp/bin:$GOROOT/bin:/root/go/bin:$NODE_HOME/bin


