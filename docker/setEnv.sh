#!/bash/sh

mkdir -p /ebank/spdb/config
UNIONAPI_CONF_FILE=/ebank/spdb/params/config/uniontech/$UNIONAPI_CONF_FILENAME
UNIONAPI_LINK_FILE=/ebank/spdb/config/serverList.conf
if [ -f "$UNIONAPI_CONF_FILE" ]&&[ ! -f "$UNIONAPI_LINK_FILE" ]
then
  ln -s $UNIONAPI_CONF_FILE $UNIONAPI_LINK_FILE
fi
export UNIONAPI_SVR_CONF_PATH=/ebank/spdb/config/

export JAVA_OPTIONS="-Dfile.encoding=UTF-8 -Dserver.port=9005 -Dspring.cloud.config.profile=$spring_cloud_config_profile"
