#!/bin/sh

adminUser="developer"
adminPass="changeme"
idracDefaultUser="root"
idracDefaultPass="calvin"
publicKeyFile="/home/developer/.ssh/id_rsa.pub"
userIndex="4"
list="deletevDisk.list"

for server in `cat $list`;
do
    echo "Configuring idrac for server: $server ..."
    echo "getting the existing vdisks"

	vDiskCmdOutput=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn raid get vdisks`
	echo "\n\n"
	echo "--- $server -----------------------------"
	echo "$vDiskCmdOutput"
	echo "----------------------------------------------"
	echo ">> Raid 0 is configured with 2 disks ..."
	echo ">> deleting virtual disks Disk.Virtual.0:RAID.Integrated.1-1 ...."
	
	racadm -r $server -u $adminUser -p $adminPass --nocertwarn storage deletevd:Disk.Virtual.0:RAID.Integrated.1-1
	racadm -r $server -u $adminUser -p $adminPass --nocertwarn jobqueue  create RAID.Integrated.1-1 -s TIME_NOW --realtime
	racadm -r $server -u $adminUser -p $adminPass --nocertwarn jobqueue view 



	echo "\n\n"
done

