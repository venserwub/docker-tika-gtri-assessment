#!/bin/bash
#important: requires --privileged flag to work in a container.
#install iptables
apt-get update -y
echo "yes yes" | apt-get install -y iptables-persistent

iptables -A INPUT -s 192.168.0.0/16 -m time --timestart 07:00 --timestop 19:00 -j ACCEPT
iptables-save
