#!/bin/bash
a=`date +%Y-%m-%d__%H:%M:%S`
eval $(df -T -m| grep ^/dev|awk -v disksum=0 -v leftsum=0\
    '{printf("amount["NR"]=%d;left["NR"]=%d;name["NR"]=%s;usedperc["NR"]=%s;",\
    $3,$5,$7,$6);disksum=disksum+$3;leftsum=leftsum+$5}\
END {printf("parnum=%d;disksum=%d;leftsum=%d",NR,disksum,leftsum)}')

for ((i=1;i<=$parnum;i++));do
    echo "$a 1 ${name[$i]} ${amount[$i]} ${left[$i]} ${usedperc[$i]}"
done
usedpercsum=$[(100-$leftsum*100/$disksum)]
echo "磁盘信息" "$a 0 disk $disksum $leftsum ${usedpercsum}%"
