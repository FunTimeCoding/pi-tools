# pi-tools


## Setup

Run initial setup on a new pi.

```sh
fab -u pi -k -H 192.168.2.125 setup
```

Copy your SSH key to the new pi.

```sh
ssh-copy-id -i pi@192.168.2.125
```

Run an arbitrary command.

```sy
fab -u pi -k -H 192.168.2.125 -- uname -a
```
