# pi-tools

## Setup

Copy your SSH public key to a remote host.

```sh
ssh-copy-id -i pi@example.org
```

Run initial setup on a remote host.

```sh
fab -u pi -H example.org basic_setup
```

Change the hostname on a remote host.

```sh
fab -u pi -H example.org change_hostname:hydrogen
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
