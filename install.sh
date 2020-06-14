#!/bin/sh

echo "Installation started"
echo "\nInstalling the necessary packages from Entware repository"
opkg update
opkg install ipset dnsmasq-full iptables tor tor-geoip bind-dig
echo "Packages was intalled"

echo "Start copying config files"
#Tor config file
cp -f ./conf/torrc /opt/etc/tor/
#List of nodes for redirect to tor
cp -f ./conf/proxylist.txt /opt/etc/
#Dnsmasq config
cp -f ./conf/dnsmasq.conf /opt/etc/
echo "Configs was intalled"

echo "Start copying scripts"
cp ./bin/100-ipset.sh /opt/etc/ndm/fs.d/
chmod +x /opt/etc/ndm/fs.d/100-ipset.sh

cp ./bin/100-redirect_to_tor.sh /opt/etc/ndm/netfilter.d/
chmod +x /opt/etc/ndm/netfilter.d/100-redirect_to_tor.sh

cp ./bin/proxylist_ipset.sh /opt/bin/
chmod +x /opt/bin/proxylist_ipset.sh

cp ./bin/proxylist_dnsmasq.sh /opt/bin/
chmod +x /opt/bin/proxylist_dnsmasq.sh
/opt/bin/proxylist_dnsmasq.sh &

cp ./bin/proxylist_update.sh /opt/bin/
chmod +x /opt/bin/proxylist_update.sh

cp ./bin/S99proxylist /opt/etc/init.d/
chmod +x /opt/etc/init.d/S99proxylist

echo "Scripts was intalled"

echo -e "Installation completed.\nNow you need to connect to the router using telnet(port 23) or ssh (port 21) and enter the following commands:\n opkg dns-override \n system configuration save \n system reboot \n"