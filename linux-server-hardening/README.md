# Linux Server Hardening

Documentation of a practical Linux server hardening process.

The objective is to establish a secure baseline for an internet-facing Ubuntu Server while maintaining the services required by the infrastructure.

## Environment

- Operating System: Ubuntu Server
- Access: SSH
- Firewall: UFW
- Intrusion Prevention: Fail2Ban
- Authentication: SSH keys
- Web Server: Nginx
- TLS: Let's Encrypt

## Security Measures

### 1. SSH Hardening

The server should use SSH key-based authentication instead of password authentication.

Recommended configuration:

```text
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
