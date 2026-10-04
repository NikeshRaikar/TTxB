#! /bin/bash

ip link set eth0 up
ip link set eth1 up

ip link show br0 >/dev/null 2>&1 || ip link add br0 type bridge

ip link set eth0 master br0
ip link set eth0 master br0

ip link set br0 up
