# Infrastructure as Code

Infrastructure provisioning and lifecycle management using Terraform and the AWS provider.

## Technologies

- Terraform
- HashiCorp AWS Provider
- AWS EC2
- Amazon EBS
- Elastic IP
- AWS Security Groups
- Terraform State

## Capabilities Demonstrated

- Declarative infrastructure provisioning
- Terraform provider configuration
- Resource dependency management
- Infrastructure validation with `terraform validate`
- Infrastructure planning with `terraform plan`
- Infrastructure deployment with `terraform apply`
- Terraform outputs for resource information
- Persistent infrastructure state management
- Reproducible AWS infrastructure
- Separation of infrastructure configuration from application workloads

## Terraform Workflow

The infrastructure follows a standard Terraform workflow:

    terraform init
    terraform fmt
    terraform validate
    terraform plan
    terraform apply

## AWS Resources Managed

The lab infrastructure demonstrates Terraform management of:

- EC2 instances
- EBS storage volumes
- Elastic IP addresses
- Security Groups
- Resource attachments and associations

## Project Application

This capability was applied to a real AWS infrastructure project:

- [Weekly Backup Infrastructure](../../../backup/weekly-backup-infrastructure/)

The project demonstrates how Terraform can provision and manage the infrastructure required for a dedicated backup environment.
