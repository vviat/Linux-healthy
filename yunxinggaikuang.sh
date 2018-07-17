#!/bin/bash
NowTime=`date +"%Y-%m-%d__%H:%M:%S"`
Name=`hostname`
Verson=(` cat /etc/issue.net `)
CoreVerson=(`cat /proc/version| awk '{printf $3}'`)
UpTime=` uptime -p`
Loadavg=` cat /proc/loadavg | awk '{print $1,$2,$3 }'` 
Alldisk=` df -m | grep ^/dev |awk -v sum=0 '{ {sum=sum+$2}} END {print sum}' `
AllAva=` df -m | grep ^/dev |awk -v sum=0 '{ {sum=sum+$4}} END {print sum}' `
Used=$[100 - $AllAva *100 /$Alldisk ]
Mem=(` free -m | head -n 2 | tail -n 1 | awk '{print $2,($3/$2*100)}' `)
Temp=` cat /sys/class/thermal/thermal_zone0/temp | awk '{print ($1/1000)}'` 
DiskNote=(`	echo $Used | awk '{if($1>90) printf"warning"; else if($1>80) printf"note"; else printf"normal"}'`)
MemNote=(`	echo ${Mem[1]} |awk '{if($1>80) printf"warning"; else if($1>70) printf"note"; else printf"normal"}'`)
CpuNote=(`	echo $Temp | awk '{if($1>70) printf"warning"; else if($1>50) printf"note"; else printf"normal"}'`)
echo "用户概况" "$NowTime $Name $Verson $CoreVerson $UpTime $Loadavg ${Alldisk} ${Used}% ${Mem[0]} ${Mem[1]}% ${Temp}°C $DiskNote $MemNote $CpuNote" 
