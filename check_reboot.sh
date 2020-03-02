source /usr/local/nagios/libexec/utils.sh

if [ -f "/var/run/reboot-required" ]
then
    echo "reboot required!"
    exit ${STATE_WARNING}
else
    echo "looks good over here..."
    exit ${STATE_OK}
fi
