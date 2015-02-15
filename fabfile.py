from fabric.api import run


def host_type():
    run('uname -s')


def path():
    run('echo $PATH')


def setup():
    run('sudo apt-get update')
    run('sudo apt-get upgrade')
