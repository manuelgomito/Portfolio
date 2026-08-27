# Compute

Practical experience with AWS compute infrastructure using Amazon EC2.

## Technologies

- Amazon EC2
- Ubuntu Server
- SSH
- Elastic IP
- AWS Security Groups
- Terraform

## Capabilities Demonstrated

- EC2 instance provisioning
- Instance type selection
- Ubuntu Server deployment
- SSH-based administration
- Public and private IP management
- Elastic IP association
- Security Group integration
- Instance lifecycle management
- Infrastructure provisioning with Terraform

## Infrastructure Administration

The EC2 environment was configured for remote Linux administration using:

    SSH
    AWS CLI
    Terraform

Security Groups were used to control inbound network access to the instance.

## Infrastructure as Code

EC2 resources were provisioned and managed declaratively using Terraform and the AWS provider.

The configuration separates compute resources from storage, networking, and other infrastructure components.

## Project Application

The compute capability was applied to the following AWS infrastructure project:

- [Weekly Backup Infrastructure](../../../backup/weekly-backup-infrastructure/)

The project uses an EC2 instance as the compute layer for the backup environment.
