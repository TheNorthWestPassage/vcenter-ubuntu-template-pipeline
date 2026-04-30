import pytest

def test_ssh_running_and_enabled(host):
    ssh = host.service("ssh")
    assert ssh.is_running
    assert ssh.is_enabled

def test_python3_installed(host):
    python3 = host.package("python3")
    assert python3.is_installed

def test_management_user_exists(host):
    user = host.user("ansible")
    assert user.exists
    assert "sudo" in user.groups

def test_minimal_install_packages(host):
    # Check for packages that should NOT be present in a minimal install
    assert not host.package("snapd").is_installed
    assert not host.package("telnet").is_installed

def test_ssh_config_hardening(host):
    sshd_config = host.file("/etc/ssh/sshd_config").content_string
    assert "PermitRootLogin no" in sshd_config
    assert "PasswordAuthentication no" in sshd_config

def test_ufw_enabled(host):
    ufw = host.service("ufw")
    assert ufw.is_running
