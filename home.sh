#!/bin/bash

########################################################################################
# Check if user has root privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
########################################################################################

########################################################################################
# Updating and Upgrading the system
apt-get update 
apt-get upgrade
apt-get install net-tools ufw -y
########################################################################################

########################################################################################
# https://docs.docker.com/engine/install/debian/
apt-get install ca-certificates curl gnupg -y

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
########################################################################################

########################################################################################
echo "" >> /etc/sudoers
echo "# This was added from the install.sh" >> /etc/sudoers
echo "bugoy    ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "Added sudoers"
########################################################################################

########################################################################################
echo "" >> /etc/systemd/logind.conf
echo "# This was added from the install.sh" >> /etc/systemd/logind.conf
echo "HandleLidSwitch=ignore" >> /etc/systemd/logind.conf
echo "HandleLidSwitchExternalPower=ignore" >> /etc/systemd/logind.conf
echo "HandleLidSwitchDocked=ignore" >> /etc/systemd/logind.conf
echo "Disabled laptop close lid"
########################################################################################

########################################################################################
echo "" >> /etc/ssh/sshd_config
echo "# This was added from the install.sh" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "SSH enabled"
########################################################################################

########################################################################################
# Disabling the GUI
systemctl set-default multi-user.target
########################################################################################

########################################################################################
# Firewall Stuff
# apt install ufw
ufw allow 22
########################################################################################


########################################################################################
> .bashrc
echo "" >> .bashrc
########################################################################################
