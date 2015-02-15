from fabric.api import run


def host_type():
    run('uname -s')


def path():
    run('echo $PATH')


def setup():
    run('sudo apt-get update')
    run('sudo apt-get upgrade')


def basics():
    run('sudo apt-get install -y htop vim-nox avahi-daemon')


def audio():
    run('sudo apt-get install -y sox')


def tools():
    run('sudo apt-get install -y bc tmux')
