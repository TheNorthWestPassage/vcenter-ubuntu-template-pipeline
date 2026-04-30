# Template Pipeline Project Instructions

## Engineering Standards
- **Golden Image:** Always use Ubuntu LTS (24.04+) with the `minimal` installation profile.
- **Packer:** Use HCL2 format for Packer templates. Validate all templates with `packer validate` before use.
- **Ansible:** Follow official best practices. Use roles for reusable logic and keep playbooks focused on orchestration.
- **Testing:** Every major component (Packer image, Ansible roles) must have corresponding `pytest-testinfra` tests.
- **Version Control:** Follow semantic versioning. All changes must be made via feature branches and validated through linting.

## Linting & Formatting
- **YAML:** Must pass `yamllint`.
- **Ansible:** Must pass `ansible-lint`.
- **Python:** Must follow PEP 8 and pass `flake8`.
- **Packer:** Must pass `packer fmt -check`.

## Architecture
- **Immutable Infrastructure:** Treat the golden image as immutable. All post-deployment changes should be handled by Ansible in a reproducible manner.
- **Dynamic Configuration:** Use Ansible variables and host-specific data for runtime configuration, avoiding hardcoded values in roles.

## Automated Enforcement
- **AGENTS.ME Integration:** All AI agents must adhere to these policies. If a requested change violates these standards, the agent must notify the user and suggest an alternative.
