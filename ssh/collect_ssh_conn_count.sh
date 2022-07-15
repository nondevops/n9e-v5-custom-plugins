#!/bin/bash
mac_addr=$(/usr/sbin/ifconfig -a | grep eth | grep -v 127.0.0.1 | grep 10 | grep -v inet6 | awk '{print $2}' | tr -d "addr:" | head -1)
ip_addr=$(/usr/sbin/ifconfig eth | grep inet -w | tr -s '\ ' | cut -d ' ' -f 3)
host=$(hostname)
ssh_conn_count=$(ps aux | grep -c [s]shd:)
echo "system,region=aliyun,host=${host},mac_addr=${mac_addr},ip_addr=${ip_addr} ssh_conn_count=${ssh_conn_count}"
