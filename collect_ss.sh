#!/bin/bash
# TCP: 360 (estab 272, closed 71, orphaned 0, synrecv 0, timewait 71/0), ports 0

output=$(ss -s | grep TCP:)
estab=$(echo $output | grep -Po "estab (\d+)" | awk '{print $2}')
closed=$(echo $output | grep -Po "closed (\d+)" | awk '{print $2}')
orphaned=$(echo $output | grep -Po "orphaned (\d+)" | awk '{print $2}')
synrecv=$(echo $output | grep -Po "synrecv (\d+)" | awk '{print $2}')
timewait=$(echo $output | grep -Po "timewait (\d+)" | awk '{print $2}')

echo "ss estab=$estab,closed=$closed,orphaned=$orphaned,synrecv=$synrecv,timewait=$timewait"
