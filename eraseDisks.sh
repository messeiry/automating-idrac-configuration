#!/bin/sh

adminUser="developer"
adminPass="changeme"
idracDefaultUser="root"
idracDefaultPass="calvin"
publicKeyFile="/home/developer/.ssh/id_rsa.pub"
userIndex="4"


for server in `cat eraseDisks.list`;
do

	getDisks=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn storage get pdisks`
	eraseDisk1=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn  storage secureerase: Disk.Bay.0:Enclosure.Internal.0-1:RAID.Integrated.1-1`
        eraseDisk2=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn  storage secureerase: Disk.Bay.1:Enclosure.Internal.0-1:RAID.Integrated.1-1`

	echo  "\n"
	echo "--- $server  -----------------------"
	echo "$nic1"
	echo "$eraseDisk1"
	echo "$eraseDisk2"
	echo "----------------------------------------------"
	echo "\n"
done

