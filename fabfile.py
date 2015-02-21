from fabric.api import run, execute, task, env, sudo, hide
from fabric.utils import error
import re
env.user = 'pi'
env.no_keys = True
# env.key_filename = '/path/to/keyfile.pem'


@task
def system_update():
    """Upgrade the system."""
    sudo('apt-get -qq update')
    sudo('apt-get -qqy upgrade')


@task
def basic_setup():
    """Install basic tools. This executes the system_update task first."""
    execute(system_update)
    with hide('stdout'):
        sudo('apt-get -qqy install htop vim-nox avahi-daemon tmux bc')


@task
def audio_setup():
    """Install audio tools. This executes the system_update task first."""
    execute(system_update)
    with hide('stdout'):
        sudo('apt-get -qqy install sox')


@task
def change_hostname(new_hostname=''):
    """Change the hostname of the target host."""
    if new_hostname is '':
        print('Usage: change_hostname:hydrogen')
    elif is_valid_hostname(new_hostname):
        print('New hostname: %s' % new_hostname)
        change_hostname_script = open('change-hostname.sh')
        run(change_hostname_script.read() + ' %s' % new_hostname)
        change_hostname_script.close()
    else:
        error('Invalid hostname: %s' % new_hostname)


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False

    if hostname[-1] == ".":
        # strip exactly one dot from the right, if present
        hostname = hostname[:-1]

    allowed = re.compile("(?!-)[A-Z\d-]{1,63}(?<!-)$", re.IGNORECASE)
    return all(allowed.match(x) for x in hostname.split("."))
