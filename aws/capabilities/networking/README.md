# Networking

Practical experience with AWS networking fundamentals for deploying and managing cloud infrastructure.

## Technologies

- Amazon VPC
- Subnets
- Security Groups
- Private IP addresses
- Public IP addresses
- Elastic IP
- AWS CLI
- Terraform

## Capabilities Demonstrated

- VPC resource inspection
- Subnet identification and configuration
- Security Group configuration
- Inbound traffic control
- Private and public IP management
- Elastic IP association
- Network connectivity troubleshooting
- AWS CLI-based network inspection
- Terraform-based network resource management

## Security Groups

Security Groups were used as stateful virtual firewalls to control inbound access to AWS resources.

Administrative access was restricted through SSH rules rather than exposing management services unnecessarily.

## IP Management

The infrastructure uses private IP addresses for internal AWS networking and Elastic IP addresses when a persistent public IPv4 address is required.

This allows resources to maintain a stable public endpoint even when the underlying EC2 instance is stopped and started.

## Infrastructure as Code

Networking-related resources and associations can be managed declaratively through Terraform, providing reproducible infrastructure configuration.

## Project Application

Networking concepts were applied to the following AWS infrastructure project:

- [Weekly Backup Infrastructure](../../../backup/weekly-backup-infrastructure/)
