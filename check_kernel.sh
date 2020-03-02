source /usr/local/nagios/libexec/utils.sh

current_kernel=$(uname -r)
#latest_kernel=$(find /boot/ -name vmlinuz-* | sort -V | tail -1 | sed 's/.*vmlinuz-//')
latest_kernel=$(rpm -q --last kernel | head -1 | awk '{print $1}' | sed 's/kernel-//g')


# no uname?
if [ -z "$current_kernel" ]
then
    echo "uname returns empty string?"
    exit ${STATE_CRITICAL}
fi


# no /boot/vmlinuz-* ?
if [ -z "$latest_kernel" ]
then
    echo "no /boot/vmlinuz-* found.."
    exit ${STATE_CRITICAL}
fi


# compare the strings
if [ "$current_kernel" = "$latest_kernel" ]
then
    echo "running kernel is $current_kernel"
    exit ${STATE_OK}
else
    echo "your kernel $current_kernel is outdated, please boot into $latest_kernel"
    touch /var/run/reboot-required
    exit ${STATE_WARNING}
fi
