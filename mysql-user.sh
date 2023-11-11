if [[ $1 == '' || $2 == '' || $3 == '' ]]
then
	echo -e "Error: Please provide username, password and the IP address you wish to connect from"
	exit
fi

sudo mysql <<EOF
CREATE USER '$1'@'$3' IDENTIFIED WITH mysql_native_password by '$2';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO '$1'@'$3' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
EOF

sudo systemctl reload mysql