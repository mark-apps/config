#!/bin/bash
REDIS_DIR=/usr/local/redis

#下载 redis 安装包
echo "-----开始下载redis 安装包-----"
cd /root/
if [ ! -f redis-5.0.9.tar.gz ] ; then
  wget https://download.redis.io/releases/redis-5.0.9.tar.gz
fi
echo "-----解压安装包----"
rm -rf redis-5.0.9
tar -zxvf redis-5.0.9.tar.gz

echo "----开始安装单机版redis，安装目录:$REDIS_DIR-----"
cd  redis-5.0.9
make && make install PREFIX=$REDIS_DIR
echo "---- 单机版redis安装完成，安装位置：$REDIS_DIR-----"
echo "----复制redis默认配置文件到 redis安装目录"
cp /root/redis-5.0.9/redis.conf  $REDIS_DIR/redis.conf.default
cp /root/redis-5.0.9/redis.conf  $REDIS_DIR/redis.conf
sed -i 's/daemonize no/daemonize yes/g' $REDIS_DIR/redis.conf
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' $REDIS_DIR/redis.conf


echo "----创建Redis伪集群-----"
REDIS_CLUSTER_DIR=/usr/local/redis-cluster
mkdir -p $REDIS_CLUSTER_DIR/redis7001

cp -r $REDIS_DIR/bin $REDIS_CLUSTER_DIR/redis7001/bin
cp -r $REDIS_DIR/redis.conf.default $REDIS_CLUSTER_DIR/redis7001/redis.conf

##修改配置文件
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' $REDIS_CLUSTER_DIR/redis7001/redis.conf
sed -i 's/daemonize no/daemonize yes/g'  $REDIS_CLUSTER_DIR/redis7001/redis.conf
sed -i 's/# cluster-config-file/cluster-config-file/g' $REDIS_CLUSTER_DIR/redis7001/redis.conf 
sed -i 's/# cluster-enabled yes/cluster-enabled yes/g' $REDIS_CLUSTER_DIR/redis7001/redis.conf
sed -i 's/# cluster-node-timeout 15000/cluster-node-timeout 15000/g' $REDIS_CLUSTER_DIR/redis7001/redis.conf
sed -i 's/appendonly no/appendonly yes/g' $REDIS_CLUSTER_DIR/redis7001/redis.conf
echo "masterauth redis!@#1234" >> $REDIS_CLUSTER_DIR/redis7001/redis.conf 
echo "requirepass redis!@#1234" >> $REDIS_CLUSTER_DIR/redis7001/redis.conf

cp -r $REDIS_CLUSTER_DIR/redis7001 $REDIS_CLUSTER_DIR/redis7002
cp -r $REDIS_CLUSTER_DIR/redis7001 $REDIS_CLUSTER_DIR/redis7003
cp -r $REDIS_CLUSTER_DIR/redis7001 $REDIS_CLUSTER_DIR/redis7004
cp -r $REDIS_CLUSTER_DIR/redis7001 $REDIS_CLUSTER_DIR/redis7005
cp -r $REDIS_CLUSTER_DIR/redis7001 $REDIS_CLUSTER_DIR/redis7006

sed -i 's/6379/7001/g' $REDIS_CLUSTER_DIR/redis7001/redis.conf
sed -i 's/6379/7002/g' $REDIS_CLUSTER_DIR/redis7002/redis.conf
sed -i 's/6379/7003/g' $REDIS_CLUSTER_DIR/redis7003/redis.conf
sed -i 's/6379/7004/g' $REDIS_CLUSTER_DIR/redis7004/redis.conf
sed -i 's/6379/7005/g' $REDIS_CLUSTER_DIR/redis7005/redis.conf
sed -i 's/6379/7006/g' $REDIS_CLUSTER_DIR/redis7006/redis.conf


echo "-----伪集群服务创建完成，安装目录$REDIS_CLUSTER_DIR------"

echo "----开始生成集群redis服务启动脚本------"
cd $REDIS_CLUSTER_DIR
echo "#!/bin/bash" > startRedis.sh
echo "cd $REDIS_CLUSTER_DIR/redis7001/" >> startRedis.sh
echo "./bin/redis-server redis.conf" >> startRedis.sh

echo "cd $REDIS_CLUSTER_DIR/redis7002/" >> startRedis.sh
echo "./bin/redis-server redis.conf" >> startRedis.sh

echo "cd $REDIS_CLUSTER_DIR/redis7003/" >> startRedis.sh
echo "./bin/redis-server redis.conf" >> startRedis.sh

echo "cd $REDIS_CLUSTER_DIR/redis7004/" >> startRedis.sh
echo "./bin/redis-server redis.conf" >> startRedis.sh

echo "cd $REDIS_CLUSTER_DIR/redis7005/" >> startRedis.sh
echo "./bin/redis-server redis.conf" >> startRedis.sh

echo "cd $REDIS_CLUSTER_DIR/redis7006/" >> startRedis.sh
echo "./bin/redis-server redis.conf" >> startRedis.sh

echo "echo \"-------------------------------------------------------------------------\"" >> startRedis.sh
echo "ps -ef|grep redis|grep -v grep" >> startRedis.sh
echo "echo \"-------------------------------------------------------------------------\"" >> startRedis.sh
echo "netstat -tnlp | grep redis" >> startRedis.sh

echo "-----开始生成 redis 创建集群脚本-----"
echo "#!/bin/bash" >> createCluster.sh
echo "cd $REDIS_CLUSTER_DIR/redis7001/bin/" >> createCluster.sh
echo "#创建集群" >> createCluster.sh
echo "./redis-cli --cluster create --cluster-replicas 1 \\" >> createCluster.sh
echo "127.0.0.1:7001 \\" >> createCluster.sh
echo "127.0.0.1:7002 \\" >> createCluster.sh
echo "127.0.0.1:7003 \\" >> createCluster.sh
echo "127.0.0.1:7004 \\" >> createCluster.sh
echo "127.0.0.1:7005 \\" >> createCluster.sh
echo "127.0.0.1:7006" >> createCluster.sh

chmod +x startRedis.sh
chmod +x createCluster.sh

echo "----redis伪集群搭建完成，请切换到$REDIS_CLUSTER_DIR 目录，执行 startRedis.sh 启动集群服务，执行createCluster.sh 创建集群-----"

