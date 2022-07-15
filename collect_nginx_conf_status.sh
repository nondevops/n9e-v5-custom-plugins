#!/bin/bash
region="aliyun"
mac_addr=$(/usr/sbin/ifconfig -a | grep eth | grep -v 127.0.0.1 | grep 10 | grep -v inet6 | awk '{print $2}' | tr -d "addr:" | head -1)
ip_addr=$(/usr/sbin/ifconfig eth | grep inet -w | tr -s '\ ' | cut -d ' ' -f 3)
host=$(hostname)
nginx_service=$(/usr/sbin/nginx -t > /dev/null 2>&1)
if [ $? -eq 0 ];then
	conf_status_code=0
else
	conf_status_code=1
fi

echo "nginx,region=${region},host=${host},mac_addr=${mac_addr},ip_addr=${ip_addr} conf_status_code=${conf_status_code}" 
