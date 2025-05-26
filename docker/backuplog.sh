#!/bin/bash

HOSTNAME=$(hostname) 
LOCAL_DIR=/logs/ 
LOG_PATH=/logs/$HOSTNAME.backup_applog.log
BACK_DATE=$(date +%m%d%H%M%S) 
FILE_MAX_SIZE=52428800

function print_log(){
    echo "===========$BACK_DATE=======================" >> $LOG_PATH
    echo "cd $LOCAL_DIR" >> $LOG_PATH
    ls *$HOSTNAME*.log.crn >> $LOG_PATH
}

function back_file(){
    echo " " >> $LOG_PATH
    for logfile in $(ls *$HOSTNAME*.log.crn)
    do
      FILE_SIZE=$(wc -c $logfile | awk '{print $1}')
      if [ $FILE_SIZE -ge $FILE_MAX_SIZE ]
      then
          BACK_FILE_NAME=${logfile%.log.crn}
          echo "cp -r $logfile  $BACK_FILE_NAME.$BACK_DATE.log" >> $LOG_PATH
          cp -r $logfile  $BACK_FILE_NAME.$BACK_DATE.log
          cat /dev/null > $logfile
          echo "[ok]" >> $LOG_PATH
      fi
    done
}

if [ -d $LOCAL_DIR ]
then
	cd $LOCAL_DIR
	print_log
	back_file
	echo "backfile shell script done!!!" >> $LOG_PATH
else
	echo "dir not exist! back error" >> $LOG_PATH
fi
