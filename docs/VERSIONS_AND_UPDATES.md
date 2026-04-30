# Version Control & Update Strategy

## Versioning Policy
This project uses [Semantic Versioning 2.0.0](https://semver.org/).
- **MAJOR:** Incompatible API changes (e.g., changing the base OS or Packer builder type).
- **MINOR:** Functionality added in a backwards-compatible manner (e.g., adding a new Ansible role or updating the minor version of a base OS).
- **PATCH:** Backwards-compatible bug fixes or security patches.

## Update Strategy
- **Base Image:** The golden image is rebuilt monthly or when critical security patches are released for Ubuntu.
- **Ansible Roles:** Roles are updated as needed. Changes must be tested against the latest golden image before being merged.
- **Rollback:** In case of a failed deployment, vCenter snapshots or previous versions of the Packer template can be used for rapid rollback.

## Git Workflow
1.  **Main Branch:** Production-ready code.
2.  **Develop Branch:** Integration branch for new features.
3.  **Feature Branches:** Used for all development. Merged into `develop` via PRs.
4.  **Releases:** Tagged on the `main` branch.
