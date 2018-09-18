#!/bin/bash
apt-get update && apt-get upgrade -y
wait
service webmin start
service bind9 start
while true
do
if [[ $(service webmin status) = *stopped* ]]
then
break
else
sleep 5m
fi
done