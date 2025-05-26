cp /etc/hosts /tmp/hosts
sed -i 's/172.17/#172.17/g' /tmp/hosts
cat /tmp/hosts > /etc/hosts

#set crontab for rotate log file
sed -i -e 's/required/sufficient/g' /etc/pam.d/crond
sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond
/usr/sbin/crond start
touch spdbms.cron
if [ '' != "$BACKUPLOG_CRONEXPRESSION" ]
then
    echo "$BACKUPLOG_CRONEXPRESSION"' sh /ebank/backuplog.sh' >> spdbms.cron
else
    echo '*/3 * * * * sh /ebank/backuplog.sh' >> spdbms.cron
fi
crontab spdbms.cron
