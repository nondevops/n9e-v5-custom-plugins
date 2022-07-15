#!/bin/bash

# 检测域名到期状态

# 检测whois命令是否存在,不存在则安装jwhois包
function is_install_whois() {
    which whois &> /dev/null
    if [ $? -ne 0 ];then
        yum install -y jwhois
    fi
}

is_install_whois

# 定义需要被检测的域名列表
domain_list=(
baidu.com
weibo.com
51cto.com
nic.top
baidu.tech
baidu.la
)

function check_domain() {
  domain=$1
  ts=$(date +%s)
  localip=$(/usr/sbin/ifconfig `/usr/sbin/route|grep '^default'|awk '{print $NF}'`|grep inet|awk '{print $2}'|head -n 1)
  timeout_time="timeout 30 "
  ping -c1 223.5.5.5 &> /dev/null
  if [ $? -eq 0 ];then
    domain_tmp=`echo $domain |cut -d '.' -f 2`
    if [ "$domain_tmp" == "com" ];then
        # whois baidu.com | grep "Expiration Date" |awk '{print $5}' | cut -c1-10 | awk -F '-' '{print $1 $2 $3}'
        expire_datea=`${timeout_time} whois $domain | grep "Expiration Date" |awk '{print $5}' | cut -c1-10 | awk -F '-' '{print $1 $2 $3}'`

    elif [ "$domain_tmp" == "cn" -o "$domain_tmp" == "com.cn" ];then
        expire_date=`${timeout_time} whois $domain | grep "Expiration Time" | awk '{print $3}' | awk -F '-' '{print $1 $2 $3}'`

    elif [ "$domain_tmp" == "la" -o "$domain_tmp" == "top" -o  "$domain_tmp" == "tech" ];then
        expire_date=`${timeout_time} whois $domain | grep 'Expiry Date' | awk '{print $4}'|cut -d 'T' -f 1`
    fi

    END_TIME_STAMP=$(date +%s -d "${expire_date}") 
    NOW_TIME_STAMP=$(date +%s)
    domain_expire_days=$[$[$END_TIME_STAMP-$NOW_TIME_STAMP]/86400]
    metrics="domain,localip=${localip},domain_name=${domain} expire_days=${domain_expire_days}"
    echo "$metrics"
  fi

}

for i in ${domain_list[*]}
do
  data=$(check_domain ${i})
  echo ${data}
done

