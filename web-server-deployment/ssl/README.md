# SSL/TLS Configuration

This section documents the HTTPS layer of the web server deployment.

SSL/TLS provides encrypted communication between clients and the web server and is an essential component of a production web environment.

## Certificate Management

A typical Ubuntu Server deployment can use Let's Encrypt with Certbot for automated certificate management.

Certbot can obtain and manage certificates for Nginx.

The certificate should only be requested after DNS records are correctly configured and the required HTTP and HTTPS ports are reachable.

## HTTPS Configuration

The production web server should provide:

- HTTPS on port 443
- HTTP to HTTPS redirection
- Valid TLS certificate
- Automatic certificate renewal
- Secure TLS configuration
- Correct certificate chain

## Certificate Renewal

Let's Encrypt certificates are short-lived and require automated renewal.

Certbot should be configured with an automated renewal mechanism.

Certificate renewal should be tested periodically to ensure that certificates can be renewed before expiration.

## DNS Requirements

Before requesting a certificate, the domain must resolve to the correct server.

Typical DNS records include:

example.com       A       SERVER_IP
www.example.com   A       SERVER_IP

For IPv6 environments, an appropriate AAAA record may also be configured.

## Security Considerations

Production TLS configuration should consider:

- Modern TLS protocol versions
- Strong cipher configuration
- HTTP to HTTPS redirection
- Secure cookies
- HSTS where appropriate
- Certificate expiration monitoring
- Private key protection
- Correct file permissions

Private keys and certificate material must never be committed to Git.

Only configuration examples and documentation should be stored in this repository.

## Operational Validation

After enabling HTTPS, the deployment should be validated by checking:

- HTTPS connectivity
- Certificate validity
- Certificate hostname
- Certificate expiration
- HTTP to HTTPS redirection
- Nginx configuration
- TLS configuration

## Production Warning

The procedures documented in this file are intended for the target Linux server.

They are not intended to be executed in the portfolio development environment.

Production changes should be reviewed before execution and validated after deployment.

## Project Scope

This project documents the infrastructure concepts and operational procedures required to deploy and maintain HTTPS for a Linux web server.

It does not contain production certificates, private keys or sensitive credentials.
