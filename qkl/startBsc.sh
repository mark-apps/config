#!/bin/bash
STDOUT_LOG=/root/bscnode.log
PIDS=`ps -ef|grep geth|grep bsc-node|grep -v "grep"|awk '{print $2}'`
if [ -n "$PIDS" ]; then
    echo "$(date) - bsc node running! --->>> PID:$PIDS"
    exit 1
fi

nohup /root/bsc/geth \
--config /root/bsc/config.toml \
--datadir /root/.bitcoin/bsc-node/ \
--cache 4096 \
--maxpeers 100 \
--pprofaddr 0.0.0.0 \
--metrics \
--pprof > $STDOUT_LOG 2>&1 &

sleep 2
PIDS=`ps -ef|grep geth|grep bsc-node|grep -v "grep"|awk '{print $2}'`
if [ -n "$PIDS" ]; then
  echo "Ok ! -->>> PID: $PIDS  -->>> STDOUT: $STDOUT_LOG"
else
  echo "bsc node startup failure!!!"
fi