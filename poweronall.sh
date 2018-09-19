#!/bin/sh

adminUser="developer"
adminPass="changeme"
idracDefaultUser="root"
idracDefaultPass="calvin"
publicKeyFile="/home/developer/.ssh/id_rsa.pub"
userIndex="4"
list="openstack.list"

for server in `cat $list`;
do
        racadm -r $server -u $adminUser -p $adminPass --nocertwarn serveraction powerup

done

