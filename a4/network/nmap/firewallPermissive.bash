#!/bin/bash
IPT="/sbin/iptables"

# Flush all tables
$IPT -F # filter is the default table
$IPT -F -t nat
$IPT -F -t mangle

# State rules to make life easier
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# default ALLOW
$IPT -P INPUT ACCEPT 
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT

