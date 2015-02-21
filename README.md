# pi-tools

Most example commands contain the variable `$HOST`, thus making it easy to define the target IP or hostname in front.

```sh
HOST=192.168.1.100 fab -H $HOST basic_setup
```


## Setup

Copy your SSH public key to a remote host.

```sh
ssh-copy-id -i pi@$HOST
```

Run initial setup on a remote host.

```sh
fab -H $HOST basic_setup
```

Change the hostname on a remote host.

```sh
fab -H $HOST change_hostname:hydrogen
```


## Fabric usage

List available commands.

```sh
fab -l
```

Run a task as a different user, in this case as `shiin`.

```sh
fab -u shiin example_task
```

Run an arbitrary command.

```sy
fab -- hostname
```
