from fabric.api import run, execute, task
from fabric.utils import error
import re


@task
def basic_setup():
    """Upgrade system and install basic tools."""
    run('sudo apt-get update')
    run('sudo apt-get upgrade')
    run('sudo apt-get install -y htop vim-nox avahi-daemon tmux bc')


@task
def change_hostname(new_hostname=''):
    """Change the hostname of the target host."""
    if new_hostname is '':
        print('Usage: change_hostname:hydrogen')
    elif is_valid_hostname(new_hostname):
        print('New hostname: %s' % new_hostname)
    else:
        error('Invalid hostname: %s' % new_hostname)


@task
def audio_setup():
    """Executes basic_setup first, then installs audio tools."""
    execute(basic_setup)
    run('sudo apt-get install -y sox')


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False
    if hostname[-1] == ".":
        # strip exactly one dot from the right, if present
        hostname = hostname[:-1]
    allowed = re.compile("(?!-)[A-Z\d-]{1,63}(?<!-)$", re.IGNORECASE)
    return all(allowed.match(x) for x in hostname.split("."))
