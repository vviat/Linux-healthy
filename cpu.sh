#!/bin/bash
a=`date +%Y-%m-%d__%H:%M:%S`
loadavg=`cut -d " " -f 1-3 /proc/loadavg`
cputemp=`cat /sys/class/thermal/thermal_zone0/temp`
cputemp=`echo "scale=2;$cputemp/1000"|bc`
eval $(head -n 1 /proc/stat | awk -v sum1=0 -v idle1=0\
    '{for (i=2;i<=8;i++) {sum1=sum1+$i} printf("sum1=%d;idle1=%d;",sum1,$5)}')

sleep 0.5

eval $(head -n 1 /proc/stat | awk -v sum2=0 -v idle2=0\
    '{for (i=2;i<=8;i++) {sum2=sum2+$i} printf("sum2=%d;idle2=%d;",sum2,
$5)}')

CpuUsedPerc=`echo "scale=4;(1-($idle2-$idle1)/($sum2-$sum1))*100" | bc`
CpuUsedPerc=`printf "%.2f\n" "$CpuUsedPerc"`

WarnLenvel="normal"

if [[ `echo $cputemp '>=' 70|bc -l` = 1 ]];then
    WarnLenvel="warning"
    elif [[ `echo $cputemp '>=' 50|bc -l` = 1 ]];then
    WarnLenvel="note"
fi


echo "CPU信息" $a $loadavg $CpuUsedPerc ${cputemp}℃  $WarnLenvel
