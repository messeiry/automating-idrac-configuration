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
    echo "Creating user: $adminUser user with password: $adminPass ...."

	racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn set IDRAC.Users.$userIndex.UserName $adminUser
	racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn set IDRAC.Users.$userIndex.Password $adminPass
	racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn set IDRAC.Users.$userIndex.Privilege 0x000001ff
	racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn set IDRAC.Users.$userIndex.IpmiLanPrivilege 4
	racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn set IDRAC.Users.$userIndex.SolEnable 1
	racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn set IDRAC.Users.$userIndex.Enable 1

	echo "done creating user"

	echo "checking public key generation on localhost"	
	if [ -f "$publicKeyFile" ]
	then
		echo "$publicKeyFile was found"
		echo "Uploading public key from localhost:"
		racadm -r $server -u $idracDefaultUser -p $idracDefaultPass --nocertwarn sshpkauth -i $userIndex -k 1 -f /home/developer/.ssh/id_rsa.pub

	else
		echo "$publicKeyFile was not found, attempting to create file"
		ssh-keygen -t rsa -N "" -f $publicKeyFile
	fi

done

