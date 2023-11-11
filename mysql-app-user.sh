if [[ $1 == '' || $2 == '' ]]
then
	echo -e "Error: Please provide a username and password for your application user"
fi

sudo mysql <<EOF
CREATE USER '$1'@'localhost' IDENTIFIED WITH mysql_native_password BY '$2';
GRANT SELECT, INSERT, UPDATE, DELETE ON your_database.* TO '$1'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo systemctl restart mysql