if [[ $1 == '' ]]
then
	echo -e "Error: Please provide a secure password for the root user"
	exit
fi

echo -e "Installing MySQL Server"
sudo apt install mysql-server

echo -e "Updating MySQL root user"
sudo mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '$1';
EXIT;
EOF

sudo sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql_secure_installation
sudo systemctl restart mysql