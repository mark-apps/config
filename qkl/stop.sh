#!/bin/bash
PIDS=`ps -ef|grep geth|grep bsc-node|grep -v "grep"|awk '{print $2}'`
if [ -z "$PIDS" ]; then
   echo ">>> ERROR: The bsc node does not started!"
   exit 1
fi
echo ">>> Stopping the bsc node ..."
for PID in $PIDS ; do
    echo "kill pid $PID"
    kill -9 $PID > /dev/null 2>&1
done
echo -e "Stop completed."

