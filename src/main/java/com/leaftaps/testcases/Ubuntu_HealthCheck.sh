#!/bin/bash 
# Threshold (If the values go beyond these thresold - reboot the instance using AWS CLI) 
Threshold_CPU=60 
Threshold_Mem=60 
Threshold_Disk=70 
# Condition to allow or not allow to run 
bPassed=true 
# Memory Check 
mem_value=$(free | grep Mem | awk '{print int($3/$2*100)}') 
echo $mem_value 
if((mem_value > Threshold_Mem)); then 
 echo 'Memory is running beyond your threshold' 
 bPassed=false 
fi
# CPU Check 
cpu_value=$(top -n1 | grep 'Cpu' | awk '{print int($2)}') 
echo $cpu_value 
if((cpu_value > Threshold_CPU)); then 
 echo 'CPU is running beyond your threshold' 
 bPassed=false 
fi
# Disk Check 
disk_value=$(df / | tail -1 | awk '{ gsub("%",""); print $5}') 
echo $disk_value 
if((disk_value > Threshold_Disk)); then 
 echo 'Disk is running beyond your threshold' 
 bPassed=false 
fi
# Check if the condition is false, terminate and do not run test 
if( $bPassed); then 
 echo "Health check passed" 
else 
 echo "Health check failed and machine rebooting" 
 aws ec2 reboot-instances --instance-ids i-0a4ffebf4db24730b 
fi