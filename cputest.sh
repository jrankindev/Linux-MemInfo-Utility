#!/usr/bin/env bash

function getCPUAverage() {
    cpuAvg1Min=$(uptime | rev | awk '{print $3}' | cut -c2- | rev)
    cpuAvg5Min=$(uptime | rev | awk '{print $2}' | cut -c2- | rev)
    cpuAvg15Min=$(uptime | rev | awk '{print $1}' | rev)

    totalCPUs=$(nproc)

    totalCPUPercentUsed=$(awk "BEGIN {printf \"%.2f\n\", $cpuAvg5Min/$totalCPUs*100}")

    echo "Total % Used:$totalCPUPercentUsed"
}

result=$(getCPUAverage)
echo $result