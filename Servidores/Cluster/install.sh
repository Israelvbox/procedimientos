#!/bin/bash

sudo apt install pacemaker corosync crmsh pcs haveged -y

sudo systemctl enable corosync
sudo systemctl enable pacemaker

cp corosync.conf /etc/corosync

corosync-keygen

crm configure property stonith-enabled=false 
crm configure property no-quorum-policy=ignore
