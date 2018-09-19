#!/bin/sh

adminUser="developer"
adminPass="changeme"
idracDefaultUser="root"
idracDefaultPass="calvin"
publicKeyFile="/home/developer/.ssh/id_rsa.pub"
userIndex="4"


for server in `cat openstack.list`;
do
    echo "getting the "First Integrated NIC

	nic1=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn racdump | egrep '^NIC.Integrated.1-1-1'`

	echo  "\n"
	echo "--- $server  -----------------------"
	echo "$nic1"
	echo "----------------------------------------------"
	echo "\n"
done

