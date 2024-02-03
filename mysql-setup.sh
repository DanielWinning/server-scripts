# $1: username $2: appusername $3: ipAddress
if [[ $1 == '' || $2 == '' || $3 == '' ]]
then
	echo -e "Error: Please provide a remote username, app username and remote ip address"
	exit
fi

echo -e "Installing MySQL Server"
sudo apt install mysql-server -y

rootPassword=$(openssl rand -base64 12 | tr -d '/+=' | head -c 12)
userPassword=$(openssl rand -base64 12 | tr -d '/+=' | head -c 12)
appPassword=$(openssl rand -base64 12 | tr -d '/+=' | head -c 12)

echo -e "Updating MySQL root user and creating users"
sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '$rootPassword';
CREATE USER '$1'@'$3' IDENTIFIED WITH mysql_native_password by '$userPassword';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO '$1'@'$3' WITH GRANT OPTION;
CREATE USER '$2'@'localhost' IDENTIFIED WITH mysql_native_password BY '$appPassword';
GRANT SELECT, INSERT, UPDATE, DELETE ON your_database.* TO '$2'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

echo -e "When prompted use password: $rootPassword"

echo - "Running MySQL secure installation"
sudo mysql_secure_installation

echo -e "Restarting MySQL"
sudo systemctl restart mysql

echo -e "MySQL setup complete"
echo -e ""
echo -e "Passwords have been updated and users created."
echo -e "Credentials are displayed below."
echo -e ""
echo -e "root@localhost $rootPassword"
echo -e "$1@$3 $userPassword"
echo -e "$2@localhost $appPassword"
echo -e ""
echo -e "Keep it secret, keep it safe."