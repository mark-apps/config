#!/bin/sh

# --- Start Functions ---
usage()
{
	echo "Need to set SERVER_NAME environment variables or specify"
	echo "them in command line:"
	echo "Usage: $1 SERVER_NAME"
	echo "for example:"
	echo "$1 managedserver"
}

# --- End Functions ---

# *************************************************************************
# This script is used to start a app WebLogic Server for the domain in
# the current working directory.  
# *************************************************************************
ADMIN_URL="t3://10.142.42.20:7878"
SERVER_LOG_HOME="/opt/log/domains"

if [ "$1" = "" ] ; then
        if [ "${SERVER_NAME}" = "" ] ; then
                usage $0
                exit
        fi
else
        SERVER_NAME="$1"
        shift
fi

SERVER_NAME="${SERVER_NAME}"

EXTEND_LIB_PATH="/opt/app/extlib"

if [ -d "${EXTEND_LIB_PATH}" ] ; then
	EXT_PRE_CLASSPATH="${EXT_PRE_CLASSPATH}:${EXTEND_LIB_PATH}/ifxjdbc-3.5.jar:${EXTEND_LIB_PATH}/ifxtools-3.5.jar:${EXTEND_LIB_PATH}/ifxlang-3.5.jar"
	EXT_PRE_CLASSPATH="${EXT_PRE_CLASSPATH}:${EXTEND_LIB_PATH}/bcprov-jdk14-127.jar:${EXTEND_LIB_PATH}/pe-xmlserial-guard.jar:"
	export EXT_PRE_CLASSPATH
fi

export JAVA_OPTIONS="-Dfile.encoding=GBK -Djava.awt.headless=true -Dweblogic.wsee.wstx.wsat.deployed=false"

SERVER_LOG_FILE=${SERVER_LOG_HOME}/${SERVER_NAME}.out
SERVER_LOG_FILE_SUFFIX=`date +%u`

if [ -f "${SERVER_LOG_FILE}" ] ; then
	cat ${SERVER_LOG_FILE} > ${SERVER_LOG_FILE}.${SERVER_LOG_FILE_SUFFIX}
	cat /dev/null > ${SERVER_LOG_FILE}
fi

nohup ./startManagedWebLogic.sh ${SERVER_NAME} ${ADMIN_URL} >>${SERVER_LOG_FILE} 2>&1 &
