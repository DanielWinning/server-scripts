#!/usr/bin/env bash
if [[ $1 == '' || $2 == '' ]]
then
	echo -e "Error: Please provide domain name and email address"
	exit
fi

echo -e "Updating package manager"
sudo apt update -y

echo -e "Installing required packages"
sudo apt install nginx php8.2-fpm php-cli unzip git composer nodejs npm php-curl php-gd -y

echo -e "Allow Nginx through firewall"
sudo ufw allow 'Nginx Full'

echo -e "Downloading and generating website config"
sudo bash -c "curl https://raw.githubusercontent.com/DanielWinning/server-scripts/main/webserver.conf > /etc/nginx/sites-available/$1"
sudo sed -i "s/domain.com/$1" /etc/nginx/sites-available/"$1"
sudo ln -s /etc/nginx/sites-available/"$1" /etc/nginx/sites-enabled/

sudo unlink /etc/nginx/sites-enabled/default

echo -e "Creating website directories"
sudo chown -R $USER:$USER /var/www/
sudo mkdir -p /var/www/"$1"/public

sudo bash -c "curl https://raw.githubusercontent.com/DanielWinning/server-scripts/main/nginx.html > /var/www/$1/public/index.html"

echo -e "Installing Certbot dependencies"
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo -e "Generating SSL certificate for $1"
sudo certbot --nginx --no-interactive -m "$2" -d "$1" --agree-tos

echo -e "Generating SSH key"
ssh-keygen

echo -e "Clearing NPM cache and setting up node for command line usage"
sudo npm cache clean -f
sudo npm install -g n -y
sudo n stable

echo -e "Setup complete"