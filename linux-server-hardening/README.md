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

SSH is one of the primary attack surfaces of an internet-facing Linux server. The objective of this configuration is to reduce the risk of unauthorized access while maintaining secure administrative access.

#### Security Controls

The example configuration is available at:

`ssh/sshd_config.example`

The main controls include:

* Disable direct root login
* Use SSH public key authentication
* Disable password-based authentication
* Limit authentication attempts
* Reduce the SSH login grace period
* Disable X11 forwarding
* Disable SSH agent forwarding
* Disable TCP forwarding when it is not required
* Enable verbose SSH logging

#### Example Configuration

```text
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
MaxAuthTries 3
LoginGraceTime 30
X11Forwarding no
AllowAgentForwarding no
AllowTcpForwarding no
LogLevel VERBOSE
```

#### Safe Deployment Procedure

SSH configuration changes should be validated before being applied to a production server.

First, create a backup of the existing configuration:

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```

Validate the SSH configuration:

```bash
sudo sshd -t
```

If the command returns no output, the configuration syntax is valid.

Reload the SSH service:

```bash
sudo systemctl reload ssh
```

Do not terminate the existing SSH session immediately.

Open a second terminal and establish a new SSH connection to verify that authentication is still working.

#### Important Security Consideration

Disabling password authentication before confirming that SSH key authentication works can lock administrators out of the server.

For production systems:

1. Confirm SSH key authentication works.
2. Keep the current administrative session open.
3. Validate the SSH configuration with `sshd -t`.
4. Reload the SSH service.
5. Test a new SSH connection.
6. Only then terminate the original session.

#### Verification

Check the SSH service:

```bash
sudo systemctl status ssh
```

Check the effective SSH configuration:

```bash
sudo sshd -T
```

Filter relevant security settings:

```bash
sudo sshd -T | grep -E 'permitrootlogin|pubkeyauthentication|passwordauthentication|maxauthtries|logingracetime'
```
### 2. UFW Firewall

UFW (Uncomplicated Firewall) is used to implement a default-deny inbound firewall policy.

The example configuration is available at:

`firewall/ufw-rules.sh`

The baseline allows only the services required for a typical web server:

| Port | Protocol | Purpose |
|---|---|---|
| 22 | TCP | SSH |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |

The default policies are:

```text
Incoming traffic: DENY
Outgoing traffic: ALLOW
