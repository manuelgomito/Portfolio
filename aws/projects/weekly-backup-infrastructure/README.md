# Weekly Backup Infrastructure

Production-like AWS backup infrastructure designed to provide a dedicated and persistent storage environment for Linux server backups.

The infrastructure is provisioned and managed using Terraform, with AWS services integrated for compute, storage, networking and secure administration.

## Architecture

The environment consists of:

- Amazon EC2 running Ubuntu Server
- Dedicated Amazon EBS volume for backup storage
- Elastic IP for stable remote access
- VPC and subnet integration
- AWS Security Group for network access control
- Terraform for infrastructure provisioning
- AWS CLI for infrastructure inspection and validation

## Infrastructure Components

| Component | Configuration |
|---|---|
| Compute | Amazon EC2 `t3.micro` |
| Operating System | Ubuntu Server 24.04 LTS |
| Root Storage | 10 GB encrypted gp3 |
| Backup Storage | 150 GB encrypted EBS |
| Backup Volume Type | `sc1` |
| Network | Amazon VPC |
| Public Address | Elastic IP |
| Access | SSH |
| IaC | Terraform |
| Validation | AWS CLI |

## Terraform

The infrastructure is defined using Terraform resources for:

- EC2 instance provisioning
- Encrypted root storage
- Dedicated EBS backup storage
- EBS volume attachment
- Elastic IP allocation
- Elastic IP association

Terraform variables separate infrastructure logic from environment-specific values.

Example configuration:

`terraform/terraform.tfvars.example`

No AWS account-specific identifiers or credentials are included in the repository.

## Persistent Backup Storage

The dedicated EBS volume is formatted with `ext4` and mounted at:

`/backup`

Persistent mounting is configured through `/etc/fstab` using the filesystem UUID.

The configuration was validated by:

- Mounting the volume
- Writing and removing a test file
- Verifying available storage
- Rebooting the EC2 instance
- Confirming that `/backup` was automatically mounted after reboot

## Elastic IP

An Elastic IP is associated with the backup instance to provide a stable public IPv4 address across instance stop/start operations.

This avoids relying on the temporary public IPv4 address assigned directly to the EC2 instance.

## Security

The infrastructure uses:

- Encrypted EBS volumes
- AWS Security Groups
- SSH-based administration
- Private IP addressing inside the VPC
- Terraform-managed infrastructure
- No credentials stored in the repository

Security Group rules are kept outside the public Terraform configuration because they depend on the target environment.

## Validation

The infrastructure was validated using both Terraform and AWS CLI.

Terraform validation included:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
