#!/bin/bash
if [[ $1 == '' ]]
then
	echo -e "Error: Please provide a name for your Sudo user."
	exit
fi

echo -e "Disabling Kernel upgrade notifications"
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf

echo -e "Updating package list"
sudo apt update -y

echo -e "Installing Git"
sudo apt install git -y

echo -e "Creating new user with username $1"
adduser --disabled-password --gecos "" --quiet "$1"

echo -e "Granting sudo privileges to $1"
usermod -aG sudo "$1"
rsync --archive --chown="$1":"$1" ~/.ssh /home/"$1"

echo -e "Cloning server scripts repository to /home/$1/server-scripts/"
git clone https://github.com/DanielWinning/server-scripts.git /home/"$1"/server-scripts/
sudo chmod -R +x /home/"$1"/server-scripts/

echo -e "Enabling firewall and allowing OpenSSH"
sudo ufw --force enable
ufw allow OpenSSH

echo "$1 ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR="tee -a" visudo

echo -e "User created, please exit your server and connect again with $1"