# Server Scripts

A collection of scripts to help ease the setup of new servers.

## How To Use

After creating a new server and first connecting via SSH as your root user, you can run the following command which runs some initial setup
steps and installs this repository for easy access to these scripts on your server.

```
curl https://raw.githubusercontent.com/DanielWinning/server-scripts/main/init.sh | bash -s -- <username>
```

You can then easily use the rest of the scripts provided by this package.

### Available Scripts

### ~/server-scripts/webserver.sh {domain} {email}

> **Before Running**: This script will create an SSL certificate and the server config for your
> domain name. Please ensure you have pointed the desired domain to your server and it has propagated before
> running this script.

Use this script after running the init script to install an Nginx webserver ready to serve HTML/PHP.

### ~/server-scripts/mysql-setup.sh {username} {appUsername} {ipAddress}

This command installs MySQL Server and creates a user with the specified `{username}` that can connect from your specified `{ipAddress}`.

Also creates an application user for use by your web application with the username `{appUsername}`.