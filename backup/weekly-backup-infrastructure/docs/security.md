# Backup System Security

This document describes the security controls applied to the weekly backup system.

The security model protects the communication between the source server and backup server, restricts access to backup resources, and reduces the risk of unauthorized modification or exposure of backup data.

## 1. Security Objectives

The backup security model aims to provide:

- Secure data transfer
- Controlled administrative access
- Restricted backup access
- Protection of backup storage
- Protection against unauthorized execution
- Protection of credentials and private keys
- Operational visibility
- Separation between production and backup environments

The backup system is designed so that security controls are applied throughout the backup lifecycle.

## 2. SSH Authentication

SSH is used as the secure communication channel between the source server and backup server.

Authentication uses SSH keys rather than passwords.

The connection follows this model:

Source Server
  │
  │ SSH Authentication
  ▼
Backup Server

SSH provides:

- Encrypted communication
- Server authentication
- Key-based user authentication
- Secure transport for `rsync`

Password-based authentication should not be required for automated backup operations.

## 3. Ed25519 SSH Keys

The backup system uses Ed25519 SSH keys for automated authentication.

The private key remains on the source server and must never be stored in the public repository.

The public key is installed on the backup server for the account used by the backup process.

The key relationship is:

Source Server
  │
  ├── Private Key
  │
  ▼
Backup Server
  │
  └── Authorized Public Key

Private keys must be protected with appropriate filesystem permissions.

## 4. Restricted Backup Access

The backup account should have only the permissions required to perform backup operations.

Access should be restricted to trusted systems and authorized administrators.

The backup server should not provide unnecessary services or unrestricted access to the backup environment.

The objective is to reduce the attack surface and limit the impact of a compromised credential.

## 5. Data Transfer Security

Backup data is synchronized using `rsync` over SSH.

`rsync` itself is responsible for synchronization, while SSH provides the encrypted transport.

The transfer model is:

Source Data
    │
    ▼
rsync
    │
    ▼
SSH Encrypted Channel
    │
    ▼
Backup Server
    │
    ▼
Persistent Storage

Backup data should not be transferred using unencrypted protocols.

## 6. Backup Storage Protection

Backup storage is dedicated to backup data and is not intended to be publicly accessible.

The storage should be mounted only on the backup server and accessed through controlled system accounts and services.

Storage protection includes:

- Restricted filesystem permissions
- Controlled administrative access
- Monitoring of available capacity
- Persistent storage configuration
- Protection against accidental modification

The backup storage should remain independent from the operating system used by the backup server whenever the underlying infrastructure supports this model.

## 7. Execution Lock

The backup workflow uses an execution lock to prevent concurrent backup processes.

This is primarily a reliability control, but it also contributes to operational security.

Without a lock, multiple executions could simultaneously modify the backup destination and create inconsistent results.

The model is:

Backup Process
     │
     ▼
Execution Lock
     │
     ├── Lock Available → Continue
     │
     └── Lock Exists → Stop / Reject Execution

## 8. Credentials and Secrets

Credentials, private keys, tokens, passwords, and other sensitive information must not be stored in the public repository.

Environment-specific values should be provided through protected configuration mechanisms.

The public project should contain only:

- Documentation
- Sanitized configuration examples
- Non-sensitive scripts
- Generic infrastructure information

Sensitive operational data must remain outside the public repository.

## 9. Repository Security

The public repository intentionally excludes infrastructure-specific information that could expose the operational environment.

The repository must not contain:

- Private SSH keys
- Passwords
- API tokens
- Cloud credentials
- Account identifiers when unnecessary
- Internal IP addresses
- Sensitive host information
- Production secrets
- Private configuration files

Example configuration files should use placeholders instead of real credentials or infrastructure values.

## 10. Backup Server Hardening

The backup server should follow a minimal security configuration.

Recommended controls include:

- Minimal installed services
- Regular security updates
- Restricted SSH access
- Strong authentication
- Firewall rules
- Controlled user permissions
- Monitoring and logging
- Removal of unnecessary software

The backup server should be treated as a security-sensitive system because it contains copies of production data.

## 11. Network Security

Network access to the backup server should be restricted to the connections required by the backup architecture.

The preferred communication path is:

Source Server
  │
  │ Restricted SSH
  ▼
Backup Server
  │
  ▼
Backup Storage

Unnecessary public-facing services should not be enabled on the backup server.

## 12. Backup Data Integrity

Security is not limited to confidentiality.

Backup integrity is also important.

The backup process must be able to determine whether data was transferred successfully and whether the backup operation completed as expected.

Validation and monitoring therefore form part of the security model.

The relationship is:

Data Synchronization
        │
        ▼
Validation
        │
        ▼
Monitoring
        │
        ▼
Backup Status

A backup that cannot be trusted cannot reliably support recovery.

## 13. Monitoring and Detection

The Watchdog provides operational monitoring of the backup process.

It helps identify conditions such as:

- Failed backup operations
- Connectivity failures
- Storage problems
- Unexpected execution states
- Backup completion failures

Monitoring does not prevent every security incident, but it reduces the risk of failures remaining undetected.

## 14. Administrative Access

Administrative access to the backup infrastructure should be limited to authorized administrators.

Administrative credentials must not be shared through the repository or embedded in backup scripts.

Access should use secure authentication and should be logged where practical.

Administrative access should be separate from the automated backup process whenever possible.

## 15. Failure and Security Events

Security-relevant failures should be treated as operational events requiring investigation.

Examples include:

- Unexpected SSH authentication failures
- Unauthorized access attempts
- Unexpected changes to backup files
- Backup storage becoming unavailable
- Unexpected backup processes
- Repeated backup failures

Logs should be preserved sufficiently to support investigation and troubleshooting.

## 16. Public Documentation

This repository documents the architecture and security principles without exposing operational secrets.

The public documentation intentionally avoids publishing:

- Production IP addresses
- Private hostnames
- SSH private keys
- Passwords
- API credentials
- Cloud account secrets
- Internal network details

This separation allows the project to demonstrate the engineering approach without exposing the real environment.

## 17. Security Principles

The backup security model follows these principles:

- Least privilege — accounts receive only the permissions required.
- Secure transport — backup data is transferred through SSH.
- Key-based authentication — automated access does not depend on passwords.
- Separation — backup infrastructure is separated from the production system.
- Restricted access — administrative and backup access are controlled.
- Secret protection — credentials and private keys remain outside the repository.
- Defense in depth — authentication, access control, storage protection, monitoring, and validation work together.
- Recoverability — security controls must preserve the ability to recover trusted backup data.

The backup system is therefore designed to protect not only the transfer of data, but also the integrity, confidentiality, and operational availability of the backup environment.
