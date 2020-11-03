#!/bin/bash
echo "Installatie script"

echo "Update en upgrade Raspberry Pi 4B"
sudo apt-get update
sudo apt-get upgrade

echo "Installatie owncloud"
sudo apt-get install apache2
sudo apt install -y apt-transport-https lsb-release ca-certificates wget
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update
sudo apt install php7.4
sudo apt install php7.4-cli php7.4-fpm php7.4-bcmath php7.4-curl php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-sqlite3 php7.4-xml php7.4-zip
sudo service apache2 restart
cd /var/www/html
sudo rm index.html
cd /var/www/html
sudo wget https://download.owncloud.org/community/owncloud-complete-20200731.zip
sudo unzip owncloud-complete-20200731.zip
cd /var/www/html/owncloud
sudo mkdir data
sudo cp -r /home/pi/scriptJordi/apps-external /var/www/html/owncloud
sudo sudo chown -R www-data:www-data /var/www/
sudo apt-get install smbclient
sudo apt install mariadb-server

#Autostart
echo "Opstart python programma bij reboot"
sudo cp bootstart.service /home/pi
cd /home/pi
sudo cp bootstart.service /lib/systemd/system/bootstart.service
sudo chmod 644 /lib/systemd/system/bootstart.service
sudo systemctl daemon-reload
sudo systemctl enable bootstart.service

#Netwerk gedeelte
echo "Installatie netwerk gedeelte"
sudo apt install hostapd -y
sudo apt install dnsmasq -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo cp -r /home/pi/scriptJordi/pi-ap /home/pi
cd /home/pi/pi-ap
sudo chmod 755 install.sh
sudo chmod 755 ap-config.sh
sudo chmod 755 dns.sh
sudo chmod 755 firewall_Default-Policies.sh
sudo chmod 755 firewall_ipv4.sh
sudo chmod 755 firewall_ipv6.sh
sudo chmod 755 functions.sh
sudo chmod 755 hostname.sh
sudo chmod 755 kernel_modifications.sh
sudo chmod 755 login-message.sh
sudo chmod 755 packages.sh
sudo chmod 755 service-pwr-mgmnt-disable.sh
sudo chmod 755 timedate.sh
sudo chmod 755 variables.sh
sudo ./install.sh

