#!/bin/bash
a=`date +%Y-%m-%d__%H:%M:%S`
b=`free -m|head -2| tail -1 |awk '{printf "%s %s",$2,$3}'`
d=`free -m|head -2| tail -1 |awk '{printf "%.2f\n",$3/$2*100}'`

echo "内存用量" $a $b $d%
