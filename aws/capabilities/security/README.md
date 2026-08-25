# Security

Practical experience implementing security controls for AWS infrastructure and Linux-based workloads.

## Technologies

- AWS Security Groups
- SSH
- IAM fundamentals
- Ubuntu Server
- AWS CLI
- Terraform

## Capabilities Demonstrated

- Network access control
- SSH access restriction
- Security Group rule management
- Least-privilege access principles
- Secure remote administration
- AWS resource inspection
- Infrastructure security validation
- Security configuration through Terraform

## Network Security

Security Groups are used as stateful virtual firewalls to control traffic to AWS resources.

Administrative SSH access is restricted to trusted source addresses instead of allowing unrestricted internet access.

## Access Management

AWS credentials are managed outside Terraform resource definitions.

Infrastructure configuration avoids embedding sensitive credentials, private keys, or other secrets directly into the repository.

## Infrastructure as Code

Security-related infrastructure configuration can be managed declaratively with Terraform, making security controls reproducible and auditable.

## Project Application

Security practices were applied to the following AWS infrastructure project:

- [Weekly Backup Infrastructure](../../projects/weekly-backup-infrastructure/)
