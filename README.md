# Server Scripts

A collection of scripts to help ease the setup of new servers.

#### init.sh

Use this script to create a new sudo user and perform some basic setup steps for your server.

When first connecting to your server as your root user, you can immediately run the following command:

```
curl <init.sh> | bash -s -- <username>
```

After running the command please exit your server and connect again with your new user.

#### webserver.sh

Use this script after running the init script to install an Nginx webserver ready to serve HTML/PHP.

```
curl <webserver.sh> | bash -s -- <domain> <email>
```