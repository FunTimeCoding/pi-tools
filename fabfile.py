from fabric.api import run, execute, task, env
from fabric.utils import error
import re
env.user = 'pi'
env.no_keys = True
# env.key_filename = '/path/to/keyfile.pem'
grep_filter = '| grep -v "Reading database"'


@task
def basic_setup():
    """Upgrade system and install basic tools."""
    run('sudo apt-get -qq update')
    run('sudo apt-get -qqy upgrade')
    packages = 'htop vim-nox avahi-daemon tmux bc',
    run('sudo apt-get -qqy install %s %s' % packages, grep_filter,
        stdout=None)


@task
def audio_setup():
    """Executes basic_setup first, then installs audio tools."""
    execute(basic_setup)
    run('sudo apt-get -qqy install sox %s' % grep_filter, stdout=None)


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
