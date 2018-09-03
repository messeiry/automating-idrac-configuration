#!/bin/sh

adminUser="developer"
adminPass="changeme"
idracDefaultUser="root"
idracDefaultPass="calvin"
publicKeyFile="/home/developer/.ssh/id_rsa.pub"
userIndex="4"


for server in `cat server.list`;
do
    echo "Configuring idrac for server: $server ..."
    echo "getting the existing vdisks"

	vDiskCmdOutput=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn raid get vdisks`
	pDiskCmdOutput=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn raid get pdisks`

	echo "\n\n"
	echo "--- $server vdisks -----------------------"
	echo "$vDiskCmdOutput"
	echo "----------------------------------------------"
	echo "--- $server pdisks -----------------------"
	echo "$pDiskCmdOutput"
	echo "----------------------------------------------"
	echo "\n\n"
done
