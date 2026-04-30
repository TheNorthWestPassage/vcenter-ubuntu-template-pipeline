# Template Pipeline

Automated pipeline for creating Ubuntu golden images and deploying them to ESXi/vCenter with host-specific configuration.

## Features
- **Golden Image Creation:** HashiCorp Packer with cloud-init (autoinstall) for minimal Ubuntu 24.04/26.04 LTS images.
- **Automated Deployment:** Ansible playbook to clone and customize VMs in vCenter.
- **Dynamic Configuration:** Ansible roles for base OS setup and security hardening.
- **Verification:** Integrated testing with `pytest-testinfra`.
- **Policies:** Codified standards in `GEMINI.md` for AI-driven enforcement.

## Prerequisites
- HashiCorp Packer
- Ansible
- Python 3 with `pytest-testinfra`
- Access to a vCenter/ESXi environment

## Quick Start

### 1. Build the Golden Image
```bash
cd packer
# Update variables in ubuntu-server.pkr.hcl or use a .pkrvars.hcl file
packer init .
packer build ubuntu-server.pkr.hcl
```

### 2. Deploy a New VM
```bash
cd ansible
# Update variables in deploy.yml
ansible-playbook deploy.yml -i inventory.ini
```

### 3. Run Verification Tests
```bash
pytest --hosts='ansible@<vm-ip>' tests/test_golden_image.py
```

## Project Structure
- `packer/`: Packer templates and cloud-init config.
- `ansible/`: Playbooks and roles for provisioning and deployment.
- `tests/`: Pytest-testinfra verification scripts.
- `docs/`: Documentation for versioning and updates.

## Policies & Standards
See [GEMINI.md](./GEMINI.md) for detailed coding standards, linting requirements, and architectural rules.
