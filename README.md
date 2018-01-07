# PiTools

## SD card flashing

Install NOOBS on a SD card.

```sh
bin/create-noobs-sd-card.sh
```

Install raspbian on a SD card.

```sh
bin/create-raspbian-sd-card.sh
```


## Set up a new pi

Copy your SSH public key.

```sh
ssh-copy-id -i pi@example.org
```

Change the hostname.

```sh
fab -u pi -H example.org change_hostname:hydrogen
```

Update the hosts file.

```sh
fab -u pi -H example.org update_hosts_file:hydrogen.local
```

Run the `basic_setup` task.

```sh
fab -u pi -H example.org basic_setup
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
