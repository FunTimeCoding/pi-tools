from fabric.api import run, execute, task, sudo, hide, put
from fabric.utils import error
import re


@task
def test():
    """Verify fabric can run on a host."""
    run('echo "Works."')


@task
def system_update():
    """Upgrade the system."""
    sudo('apt-get -qq update')
    sudo('apt-get -qqy upgrade')


@task
def basic_setup():
    """Install basic tools. This executes the system_update task first."""
    execute(system_update)
    install_silently('htop vim-nox avahi-daemon tmux bc')


@task
def audio_setup():
    """Install audio tools. This executes the system_update task first."""
    execute(system_update)
    install_silently('sox')


@task
def change_hostname(new_hostname=''):
    """Change the hostname."""
    if new_hostname is '':
        print('Usage: change_hostname:hydrogen')
    elif is_valid_hostname(new_hostname):
        put(
            local_path='helper/change-hostname.sh',
            remote_path='change-hostname.sh',
            mode='0755'
        )
        sudo('./change-hostname.sh %s' % new_hostname)
    else:
        error('Invalid hostname: %s' % new_hostname)


@task
def update_hosts_file(fqdn):
    """Update the hosts file."""
    if fqdn is '':
        print('Usage: update_hosts_file:example.org')
    elif is_valid_hostname(fqdn):
        put(
            local_path='helper/update-hosts-file.sh',
            remote_path='update-hosts-file.sh',
            mode='0755'
        )
        sudo('./update-hosts-file.sh %s' % fqdn)
    else:
        error('Invalid FQDN: %s' % fqdn)


def install_silently(packages):
    with hide('stdout'):
        sudo('apt-get -qqy install %s' % packages)


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False

    if hostname[-1] == ".":
        # strip exactly one dot from the right, if present
        hostname = hostname[:-1]

    allowed = re.compile("(?!-)[A-Z\d-]{1,63}(?<!-)$", re.IGNORECASE)
    return all(allowed.match(x) for x in hostname.split("."))
