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

	# (a) Allow ssh into the firewall
$IPT -A INPUT -p tcp --dport 22 -j ACCEPT                                                     #(a)

	# (b) Allow ssh out of the firewall
$IPT -A OUTPUT -p tcp --dport 22 -j ACCEPT                                                    #(b)

	# (c) The 10.10.10.* network can access the web server via port 80 on the firewall.
$IPT -A FORWARD -p tcp -d 192.168.10.100 --dport 80 -j ACCEPT                                 #(c)
$IPT -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to 192.168.10.100               #(c)

	# (d) Allow the ceo to rdp from their home machine (10.10.10.18) to their office machine (192.168.10.18) using port 3389 on the firewall
$IPT -A FORWARD -p tcp -s 10.10.10.18 -d 192.168.10.18 --dport 3389 -j ACCEPT                 #(d)
$IPT -t nat -A PREROUTING -i eth0 -p tcp --dport 3389 -j DNAT --to 192.168.10.18              #(d)

	# (e) Allow the ceo to ssh to the web server using port 2222 on the firewall
$IPT -A FORWARD -p tcp -d 192.168.10.100 --dport 22 -j ACCEPT                                 #(e)
$IPT -t nat -A PREROUTING -i eth0 -p tcp --dport 2222 -j DNAT --to 192.168.10.100:22          #(e)

	# (f) All hosts within the lan share the same public IP, 10.10.10.10
$IPT -t nat -A POSTROUTING -o eth0 -j SNAT --to 10.10.10.10                                   #(f)

	# (g) All other connections through the firewall, into the firewal and out of the firewall are denied
# default drop
$IPT -P INPUT DROP                                                                            #(g)
$IPT -P OUTPUT DROP                                                                           #(g)
$IPT -P FORWARD DROP                                                                          #(g)

