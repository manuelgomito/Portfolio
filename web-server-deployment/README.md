# Web Server Deployment

Production-oriented Linux web server deployment project focused on hosting PHP-based web applications.

This project demonstrates practical infrastructure administration using Ubuntu Server, Nginx, PHP-FPM and MariaDB, with emphasis on security, reliability, performance, backups and operational maintenance.

## Architecture

```text
                         Internet
                            |
                            v
                           DNS
                            |
                            v
                    +----------------+
                    | Ubuntu Server  |
                    +----------------+
                            |
                 +----------+----------+
                 |                     |
                 v                     v
               Nginx                  SSH
                 |
        +--------+--------+
        |                 |
        v                 v
     PHP-FPM         Static Files
        |
        v
     MariaDB
        |
        v
      Redis

Additional infrastructure:

- UFW firewall
- SSL/TLS certificates
- Automated backups
- Monitoring
- Service health checks
```

## Project Objectives

The objective is to build a reproducible Linux web server environment capable of hosting production-oriented web applications.

The deployment focuses on:

- Secure server configuration
- Web server deployment
- PHP application hosting
- Database configuration
- SSL/TLS implementation
- Backup automation
- Service monitoring
- Performance considerations
- Operational troubleshooting

## Technology Stack

| Component | Technology |
|---|---|
| Operating System | Ubuntu Server |
| Web Server | Nginx |
| Application Runtime | PHP-FPM |
| Database | MariaDB |
| Object Cache | Redis |
| Firewall | UFW |
| Remote Administration | SSH |
| Encryption | SSL/TLS |
| Backup | Bash, Rclone |
| Monitoring | Bash, system services |
| Configuration | Linux CLI |
| Version Control | Git, GitHub |

## Deployment Structure

```text
web-server-deployment/
├── README.md
│
├── nginx/
│   └── site.conf.example
│
├── php/
│   └── php-fpm.conf.example
│
├── database/
│   └── mariadb.cnf.example
│
├── ssl/
│   └── README.md
│
├── backup/
│   └── backup.sh
│
└── scripts/
    └── deploy-check.sh
```

## Server Preparation

The deployment process begins with a clean Ubuntu Server environment.

Typical preparation includes:

1. Update the operating system.
2. Create and configure administrative users.
3. Configure SSH access.
4. Apply firewall rules.
5. Configure system timezone and hostname.
6. Install required packages.
7. Configure automatic security updates where appropriate.

Example package installation:

```bash
sudo apt update
sudo apt upgrade
sudo apt install nginx mariadb-server php-fpm php-mysql redis-server
```

> Commands should be reviewed and adapted to the target Ubuntu version and production environment before execution.

## Nginx Configuration

Nginx is used as the primary web server and reverse proxy.

The configuration is designed to provide:

- Virtual host support
- Static file delivery
- PHP-FPM integration
- Access and error logging
- Security headers
- Request handling
- SSL/TLS termination

Example configuration:

```text
nginx/site.conf.example
```

The configuration should be validated before being enabled:

```bash
sudo nginx -t
```

Then reload Nginx without interrupting existing connections:

```bash
sudo systemctl reload nginx
```

## PHP-FPM

PHP-FPM provides the PHP application runtime behind Nginx.

The configuration considers:

- PHP-FPM pools
- Worker management
- Resource limits
- Unix socket communication
- Process isolation
- Application performance

Example configuration:

```text
php/php-fpm.conf.example
```

Configuration must be validated before restarting the service.

## MariaDB

MariaDB is used as the relational database backend for PHP applications.

Operational considerations include:

- Database users and privileges
- Authentication
- Connection limits
- Character sets
- Resource allocation
- Backup strategy
- Database security

Example configuration:

```text
database/mariadb.cnf.example
```

Database configuration must be reviewed according to the available CPU, memory and workload of the server.

## Redis

Redis can be used as an object cache to reduce repeated database queries and improve application response times.

Typical use cases include:

- Object caching
- Session storage
- Application caching
- WordPress object cache

Redis should not be exposed directly to the public Internet.

## SSL/TLS

HTTPS is an essential part of the deployment.

The SSL/TLS layer provides:

- Encrypted client-server communication
- Certificate management
- Secure application access
- HTTP to HTTPS redirection
- Protection against network interception

Certificate configuration and renewal procedures are documented in:

```text
ssl/README.md
```

## Firewall

UFW is used to control inbound network traffic.

Typical public services include:

```text
22/tcp    SSH
80/tcp    HTTP
443/tcp   HTTPS
```

Only required services should be exposed to the Internet.

Firewall configuration should always be tested carefully before enabling restrictive policies, especially when administering a remote VPS.

## Backup Strategy

Backups are an essential part of production infrastructure.

The backup component is designed to demonstrate:

- Database backups
- Application file backups
- Backup compression
- Remote storage
- Backup verification
- Retention considerations
- Restore procedures

Backup script:

```text
backup/backup.sh
```

The objective is not only to create backups, but to ensure that backups can actually be restored.

## Deployment Validation

After deployment, the server should be validated before being considered operational.

The validation script checks important infrastructure components such as:

- Nginx
- PHP-FPM
- MariaDB
- Redis
- Network ports
- Disk usage
- Memory
- Service status
- Configuration validity

Validation script:

```text
scripts/deploy-check.sh
```

## Security Considerations

Security is treated as part of the deployment rather than as a separate step.

Important controls include:

- SSH key authentication
- Restricted SSH access
- Firewall configuration
- TLS/HTTPS
- Service isolation
- File permissions
- Database access control
- Log monitoring
- Regular system updates
- Backup protection

Sensitive credentials, private keys, `.env` files and production configuration files must never be committed to Git.

## Performance Considerations

The deployment considers several factors that can affect web application performance:

- Nginx configuration
- PHP-FPM worker management
- Redis object caching
- Database configuration
- Disk usage
- Memory utilization
- Network latency
- Application-level caching

Performance tuning should be based on actual resource utilization and application workload rather than arbitrary configuration values.

## Monitoring & Troubleshooting

Operational monitoring should include:

```bash
systemctl status nginx
systemctl status php*-fpm
systemctl status mariadb
systemctl status redis-server
```

Network services can be inspected with:

```bash
ss -tuln
```

Disk usage:

```bash
df -h
```

Memory:

```bash
free -h
```

System logs can be inspected using:

```bash
journalctl
```

Application and web server logs should also be reviewed when investigating errors or performance issues.

## Production Checklist

Before considering a deployment complete:

- [ ] Ubuntu Server updated
- [ ] Administrative SSH access configured
- [ ] Root SSH login disabled
- [ ] SSH key authentication configured
- [ ] Firewall configured
- [ ] Required ports exposed only
- [ ] Nginx installed and validated
- [ ] PHP-FPM configured
- [ ] MariaDB secured
- [ ] Redis configured
- [ ] SSL/TLS enabled
- [ ] Application deployed
- [ ] Backups configured
- [ ] Backup restoration tested
- [ ] Monitoring configured
- [ ] Logs reviewed
- [ ] Services validated
- [ ] Sensitive configuration excluded from Git

## Lessons Demonstrated

This project demonstrates practical knowledge of:

- Linux server administration
- Web infrastructure
- Nginx
- PHP-FPM
- MariaDB
- Redis
- SSH security
- Firewall management
- SSL/TLS
- Backup automation
- Service management
- System monitoring
- Troubleshooting
- Production-oriented infrastructure practices

## Project Status

**Status:** In development

The project is being expanded incrementally with configuration examples, deployment automation, validation scripts and operational documentation.

## Related Project

This repository also contains a Linux server hardening project covering SSH security, UFW, Fail2Ban and security auditing.

[Linux Server Hardening](../linux-server-hardening)

## Objective

The objective of this project is to demonstrate how a Linux server can be transformed from a clean VPS into a structured, secure and maintainable web hosting environment.

The configuration examples are intentionally separated from production systems so that they can be reviewed, versioned and reproduced safely.

---

**Focus:** Linux Infrastructure · Web Servers · Security · Databases · Backups · Monitoring · DevOps