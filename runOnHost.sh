#!/bin/sh

#specify docker path
DOCKERPATH="/var/lib/docker"
#AKS always mounts temp disk at /mnt
TEMPDISKMOUNT="/mnt"

#Function to check if path is mounted
isMounted() {
    findmnt -rno SOURCE,TARGET "$1" >/dev/null;
}

#Function to get temporary disk based on default mount path
getTemporaryDiskPath() {
    temporaryDisk=$(findmnt -rno SOURCE "$TEMPDISKMOUNT")
    echo $temporaryDisk
}

#Check if disk is mounted otherwise mount the disk
if isMounted $DOCKERPATH;
then
    echo "$DOCKERPATH is already mounted on $TEMPDISKMOUNT"
else
    echo "$DOCKERPATH is not mounted on $TEMPDISKMOUNT"
    #Extract tem disk path
    tempDiskPath=$(getTemporaryDiskPath)
    echo "Temporary disk path is $tempDiskPath"
    echo "Changing  mount for $DOCKERPATH to $TEMPDISKMOUNT"
    #Mount disk path
    mount $tempDiskPath $DOCKERPATH
    #Check mount point
    diskMounted=$(mountpoint -q $DOCKERPATH && echo "True" || echo "False")
    #Restart docker
    if [ $diskMounted = "True" ]
    then
        echo "$DOCKERPATH successfully mounted on $tempDiskPath"
        #Restart docker
        which systemctl && sudo systemctl restart docker
    else
        echo "$DOCKERPATH could not be mounted on $tempDiskPath"
    fi
fi