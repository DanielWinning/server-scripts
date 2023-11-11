# Server Scripts

A collection of scripts to help ease the setup of new servers.

## Available Scripts

### init.sh

Use this script to create a new sudo user and perform some basic setup steps for your server.

When first connecting to your server as your root user, you can immediately run the following command:

```
curl https://raw.githubusercontent.com/DanielWinning/server-scripts/main/init.sh | bash -s -- <username>
```

After running the command please exit your server and connect again with your new user.

### webserver.sh

> **Before Running**: This script will create an SSL certificate and the server config for your
> domain name. Please ensure you have pointed the desired domain to your server and it has propagated before
> running this script.

Use this script after running the init script to install an Nginx webserver ready to serve HTML/PHP.

```
curl https://raw.githubusercontent.com/DanielWinning/server-scripts/main/webserver.sh | bash -s -- <domain> <email>
```