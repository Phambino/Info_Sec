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

    # (a) The only publicly routable ip address in the organization is 93.184.216.34,
    #     this means that all of the hosts on the 192.168.*.* network share the one
    #     public IP 93.184.216.34

$IPT -t nat -A POSTROUTING -o eth0 -j SNAT --to 93.184.216.34                                 #(a)

    # (b) As far as the internet is concerned, the organization is running a web server
    #     at IP 93.184.216.34. All http traffic received at Firewall1 is forwarded to
    #     192.168.10.100.

$IPT -A FORWARD -p tcp -d 192.168.10.100 --dport 80 -j ACCEPT
$IPT -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to 192.168.10.100               #(b)

    # (c) As far as the internet is concerned, the organization is running a mail server
    #     at IP 93.184.216.34. All smtp traffic received at Firewall1 is forwarded to
    #     192.168.10.25.
    
$IPT -A FORWARD -p tcp -d 192.168.10.25 --dport 80 -j ACCEPT
$IPT -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to 192.168.10.25                #(c)

    # (d) Firewall1 allows ssh in, but only from the admins office machine
    #     192.168.11.19, and from the admins home machine 128.2.2.17.

$IPT -A INPUT -p tcp --dport 22 --source 128.2.2.17 -j ACCEPT
$IPT -A INPUT -p tcp --source 192.168.11.19 --dport 22 -j ACCEPT                                 #(d)
    
    # (e) The ceo can, from their home machine (34.14.10.18) rdp into their office
    #     desktop (192.168.11.18) using port 3389 on Firewall1.

$IPT -A FORWARD -p tcp -s 34.14.10.18 -d 192.168.10.11 --dport 3389 -j ACCEPT                 #(e)
$IPT -t nat -A PREROUTING -s 34.14.10.18 -p tcp --dport 3389 -j DNAT --to 192.168.10.11  

    # (f) For convenience, the admin can ssh into their office machine via...
    #     ssh -p 2222 93.184.216.36 # only works from 128.2.2.17

$IPT -A FORWARD -p tcp -s 128.2.2.17 -d 192.168.10.11 --dport 22 -j ACCEPT                   #(f)
$IPT -t nat -A PREROUTING -s 128.2.2.17 -p tcp --dport 2222 -j DNAT --to 192.168.10.11:22

    # Similarly, the ceo can ssh into their ceo desktop via...
    # ssh -p 2222 93.184.216.36 # only works from 34.14.10.18

$IPT -A FORWARD -p tcp -s 34.14.10.18 -d 192.168.10.11 --dport 22 -j ACCEPT                                                                          #(f)
$IPT -t nat -A PREROUTING -i eth0 -p tcp --dport 2222 -j DNAT --to 192.168.10.11:22

    # (g) The mail server at 192.168.10.25 is accessible from the LAN.

# NO RULE NEEDED HERE                                                                         #(g)
    
    # (h) The web server (192.168.10.100) is running some web applications, it is accessible
    #     from the LAN. 

# NO RULE NEEDED HERE                                                                         #(h)

    # (i) To get its work done, the web server needs to connect to the postgresql db server at 192.168.11.100
    #     No other connection into the db server are allowed.
    
# NO RULE NEEDED HERE                                                                         #(i)

    # (j) All LAN machines can access the internet, but are restricted to web (http and https) traffic only. 
    #     So, for example, none of the LAN machines can ssh out past firewall1.

$IPT -A OUTPUT -i eth1 --dport 80 -j ACCEPT                                                   #(j) 
$IPT -A OUTPUT -i eth1 -j DROP 

    # (k) No other access to any hosts is allowed.

$IPT -A INPUT -j DROP                                                                         #(k)
$IPT -A OUTPUT -j DROP
$IPT -A FORWARD -j DROP

    # (l) 17.17.17.17 has been found to be attacking the organizations systems. Access
    #     to all services from this IP is denied. 

$IPT -A INPUT -s 17.17.17.17 DROP                                                                          #(l)

    # (m) As a precaution, in case 17.17.17.17 has compromised one of our systems, 
    #     no outgoing connections to 17.17.17.17 are allowed.

$IPT -A OUTPUT -s 17.17.17.17 DROP                                                                        #(m)


