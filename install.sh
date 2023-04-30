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
########################################################################################

########################################################################################
# Disabling the GUI
systemctl set-default multi-user.target
########################################################################################

########################################################################################
echo "" >> /etc/ssh/sshd_config
echo "# This was added from the sshd_config_file" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "SSH enabled"
########################################################################################

########################################################################################
# Installing docker
apt-get install ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
########################################################################################
