#!/usr/bin/env bash

#check if memavailable exists, if it does then show memavailable vs memtotal and calculate percentage
#	if it does not exist, then show memfree vs memtotal and calculate percentage
#show swapused (swaptotal - swapfree) vs swaptotal and calculate percentage

#testvar=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
#awk "BEGIN {printf \"%.2f\n\", $testvar/1000}"
#change to 1mil for gigabyte, above is for megabytes
#testvar is in kb

clear

memTotalVar=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')

if grep -q MemAvailable /proc/meminfo; then
    memAvailableVar=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    memUsedVar=$(($memTotalVar - $memAvailableVar))

    echo "Memory Total: "$memTotalVar
    echo "Memory Free(Available): "$memAvailableVar
    echo "Memory Used: "$memUsedVar
else
    memFreeVar=$(cat /proc/meminfo | grep MemFree | awk '{print $2}')
    memUsedVar=$(($memTotalVar - $memFreeVar))

    echo "Memory Total: "$memTotalVar
    echo "Memory Free: "$memFreeVar
    echo "Memory Used: "$memUsedVar
fi

if [ $memUsedVar -gt 0 ]; then
    memPercentUsedVar=$(awk "BEGIN {printf \"%.2f\n\", $memUsedVar/$memTotalVar*100}")
else
    memPercentUsedVar=0
fi

echo "Memory Used %: "$memPercentUsedVar
echo ""

swapTotalVar=$(cat /proc/meminfo | grep SwapTotal | awk '{print $2}')
swapFreeVar=$(cat /proc/meminfo | grep SwapFree | awk '{print $2}')
swapUsedVar=$(($swapTotalVar - $swapFreeVar))

if [ $swapUsedVar -gt 0 ]; then
    swapPercentUsedVar=$(awk "BEGIN {printf \"%.2f\n\", $swapUsedVar/$swapTotalVar*100}")
else
    swapPercentUsedVar=0
fi

echo "SWAP Total: "$swapTotalVar
echo "SWAP Free: "$swapFreeVar
echo "SWAP Used: "$swapUsedVar
echo "SWAP Used %: "$swapPercentUsedVar
echo ""
echo ""
