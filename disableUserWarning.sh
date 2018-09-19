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

	racadm -r $server -u $adminUser -p $adminPass --nocertwarn set iDRAC.Tuning.DefaultCredentialWarning Disabled

done

