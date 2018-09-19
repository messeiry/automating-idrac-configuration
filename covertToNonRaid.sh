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
    echo "getting physical disks info"

        pDisks=`racadm -r $server -u $adminUser -p $adminPass --nocertwarn raid get pdisks -o -p state`
        echo "\n"
        echo "--- $server -----------------------------"
        echo "$pDisks"
        echo "----------------------------------------------"
        racadm -r $server -u $adminUser -p $adminPass --nocertwarn storage converttononraid:Disk.Bay.0:Enclosure.Internal.0-1:RAID.Integrated.1-1
        racadm -r $server -u $adminUser -p $adminPass --nocertwarn storage converttononraid:Disk.Bay.1:Enclosure.Internal.0-1:RAID.Integrated.1-1
        racadm -r $server -u $adminUser -p $adminPass --nocertwarn jobqueue  create RAID.Integrated.1-1
        racadm -r $server -u $adminUser -p $adminPass --nocertwarn serveraction hardreset

        #racadm -r $server -u $adminUser -p $adminPass --nocertwarn jobqueue view
        echo "\n\n"
done

