# pi-tools

## Setup

Copy your SSH public key.

```sh
ssh-copy-id -i pi@example.org
```

Run initial setup.

```sh
fab -u pi -H example.org basic_setup
```

Change the hostname.

```sh
fab -u pi -H example.org change_hostname:hydrogen
```

Update the hosts file.

```sh
fab -u pi -H example.org update_hosts_file:hydrogen.local
```


## Fabric usage

List available commands.

```sh
fab -l
```

Run an arbitrary command.

```sy
fab -- hostname
```
