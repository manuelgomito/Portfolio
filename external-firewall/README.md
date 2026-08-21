# External Firewall

## Overview

This project documents the implementation of an external firewall for a production Linux VPS hosted on Contabo.

The firewall provides an additional network security layer before traffic reaches the server. Incoming traffic is explicitly controlled through allow rules, while all other inbound traffic is denied by default.

## Security Model

The firewall follows a **default-deny** approach:

- Required public services are explicitly allowed.
- Unnecessary ports remain blocked.
- SSH is exposed through a non-default port.
- Public access is limited to services required by the infrastructure.
- Firewall rules are managed independently from the VPS operating system.

## Allowed Inbound Services

| Service | Protocol | Port | Purpose |
|---|---|---:|---|
| SSH | TCP | 2226 | Secure server administration |
| HTTP | TCP | 80 | Web traffic |
| HTTPS | TCP | 443 | Encrypted web traffic |
| DNS | UDP | 53 | DNS queries |
| DNS | TCP | 53 | DNS queries |
| SMTP | TCP | 25 | Mail delivery |
| SMTP-SSL | TCP | 465 | Secure mail |
| SMTP-STARTTLS | TCP | 587 | Secure mail submission |
| IMAP | TCP | 143 | Mail access / STARTTLS |
| IMAPS | TCP | 993 | Encrypted mail access |
| POP3 | TCP | 110 | Mail retrieval / STARTTLS |
| POP3S | TCP | 995 | Encrypted mail retrieval |
| HestiaCP | TCP | 8083 | Hestia Control Panel |

All inbound rules are configured for public IPv4 access because these services are intended to be reachable from external networks.

## FTP

FTP is intentionally blocked at the external firewall.

The FTP service exists on the VPS, but public access is not currently required.

During validation, an external FTP connection was tested while TCP/21 was blocked and the connection timed out.

The firewall rule was temporarily enabled to verify that the FTP service itself was operational. The connection was successful, confirming that the external firewall was responsible for the previous timeout.

The FTP rule was then disabled again.

## Firewall Policy

The final rule set follows this logic:

```text
ALLOW required services
        |
        v
Process inbound traffic
        |
        v
DROP all other inbound traffic
```
