#!/bin/bash

# Project Byzantium: captive-portal.sh
# This script does the heavy lifting of IP tables manipulation under the
# captive portal's hood.  It should only be used by the captive portal daemon.

# Written by Sitwon and The Doctor.
# Copyright (C) 2013 Project Byzantium
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

IPTABLES=iptables
ARP=arp

# Set up the choice tree of options that can be passed to this script.
case "$1" in
    'initialize')
        #$IPTABLES -t nat -A POSTROUTING -o ap0 -j MASQUERADE
        #$IPTABLES -t nat -A PREROUTING -i ap0 -p tcp -j DNAT --to-destination 192.168.10.1:8080

        # Captivity portal
        #$IPTABLES -t     -N internet
        #$IPTABLES -t mangle -A PREROUTING -i ap0 -p tcp -m tcp --dport 80 -j internet
        #$IPTABLES -t mangle -A internet -j MARK --set-mark 99
        #$IPTABLES -t nat -A PREROUTING -i ap0 -p tcp -j DNAT --to-destination 192.168.10.1:8080

sudo iptables -t nat -A POSTROUTING -s 192.168.10.0/24 ! -d 192.168.10.0/24 -j MASQUERADE
sudo iptables -t nat -A PREROUTING -i ap0 -p tcp -j DNAT --to-destination 192.168.10.1:8080


#sudo iptables -t mangle -N internet
#sudo iptables -t mangle -A PREROUTING -i ap0 -p tcp -m tcp --dport 80 -j internet
#sudo iptables -t mangle -A internet -j MARK --set-mark 99
#sudo iptables -t mangle -A PREROUTING -i ap0 -p tcp -m tcp --match multiport --dports 80,443 -j DNAT --to-destination 192.168.10.1:8080



        echo "Initialized"
        exit 0
        ;;
    'add')
        # $2: IP address of client.
        CLIENT=$2

        # Isolate the MAC address of the client in question.
        CLIENTMAC=`$ARP -n | grep ':' | grep $CLIENT | awk '{print $3}'`

        # Add the MAC address of the client to the whitelist, so it'll be able
        # to access the mesh even if its IP address changes.
        $IPTABLES -t nat -I PREROUTING -m mac --mac-source $CLIENTMAC -j ACCEPT
        echo "add $2"
        exit 0
        ;;
    'remove')
        # $2: IP address of client.
        CLIENT=$2

        # Isolate the MAC address of the client in question.
        CLIENTMAC=`$ARP -n | grep ':' | grep $CLIENT | awk '{print $3}'`

        # Delete the MAC address of the client from the whitelist.
        $IPTABLES -t nat -D PREROUTING -m mac --mac-source $CLIENTMAC -j ACCEPT
        echo "remove $2"
        exit 0
        ;;
    'purge')
        # Purge all of the IP tables rules.
        $IPTABLES -F
        $IPTABLES -X
        $IPTABLES -t nat -F
        $IPTABLES -t nat -X
        $IPTABLES -t mangle -F
        $IPTABLES -t mangle -X
        $IPTABLES -t filter -F
        $IPTABLES -t filter -X
        echo "purge"
        exit 0
        ;;
    'list')
        # Display the currently running IP tables ruleset.
        $IPTABLES --list -n
        $IPTABLES --list -t nat -n
        $IPTABLES --list -t mangle -n
        $IPTABLES --list -t filter -n
        $IPTABLES -L -t nat -v
        exit 0
        ;;
    *)
        echo "USAGE: $0 {initialize |add <IP> |remove <IP> |purge|list}"
        exit 0
    esac