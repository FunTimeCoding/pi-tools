# pi-tools


## Setup

Most example commands contain the variable `$HOST`, thus making it easy to define the target IP or hostname in front.

```sh
HOST=192.168.1.100 fab -u pi -k -H $HOST basic_setup
```


Copy your SSH key to the new pi.

```sh
ssh-copy-id -i pi@$HOST
```

List available commands.

```sh
fab -l
```

Run initial setup on a new pi.

```sh
fab -u pi -k -H $HOST basic_setup
```

Run a command which takes an argument.

```sh
fab -u pi -k -H $HOST change_hostname:hydrogen
```

Run an arbitrary command.

```sy
fab -u pi -k -H $HOST -- hostname
```
