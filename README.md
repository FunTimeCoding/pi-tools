# PiTools

## Usage

This section explains how to use this project.

Run the main program.

```sh
bin/pt
```

Create a NOOBS secure digital card.

```sh
bin/create-noobs-sd-card.sh
```

Create a raspbian secure digital card.

```sh
bin/create-raspbian-sd-card.sh
```


### Set up a new Raspberry

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


### Fabric

List available commands.

```sh
fab -l
```

Run an arbitrary command.

```sy
fab -- hostname
```


## Development

This section explains how to use scripts that are intended to ease the development of this project.

Install development tools.

```sh
sudo apt-get install shellcheck
```

Run style check and show all concerns.

```sh
./run-style-check.sh
```

Build the project like Jenkins.

```sh
./build.sh
```
