#!/bin/sh

# Copy installation script to host
cp /runOnHost.sh /host

# Give execute priv to script
/usr/bin/nsenter -m/proc/1/ns/mnt -- chmod u+x /tmp/runOnHost.sh

# If the /tmp folder is mounted on the host then it can run the script
/usr/bin/nsenter -m/proc/1/ns/mnt /tmp/runOnHost.sh

# Sleep so that the Pod in the DaemonSet does not exit
echo "Sleeping pod ininitely"
sleep infinity