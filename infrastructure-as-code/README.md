# Infrastructure as Code

Infrastructure as Code (IaC) is the practice of defining and managing infrastructure through machine-readable configuration instead of manual provisioning.

This capability focuses on infrastructure automation, reproducibility, lifecycle management, and controlled changes using **Terraform**.

The repository currently contains a Terraform implementation using **AWS** as the infrastructure provider. The structure is designed so that additional providers can be added without changing the definition of the IaC domain.

## Technologies

* Terraform
* Terraform Providers
* AWS Provider
* AWS EC2
* Amazon EBS
* AWS Security Groups
* Terraform State

## IaC Concepts Demonstrated

* Declarative infrastructure definition
* Provider configuration
* Resource dependency management
* Variable-based configuration
* Infrastructure validation
* Infrastructure planning
* Infrastructure deployment
* Resource outputs
* State management
* Reproducible infrastructure
* Separation of infrastructure configuration from application workloads

## Terraform Workflow

The current infrastructure follows the standard Terraform workflow:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

### Workflow

```text
Terraform Configuration
          │
          ▼
     terraform init
          │
          ▼
      terraform fmt
          │
          ▼
   terraform validate
          │
          ▼
      terraform plan
          │
          ▼
     terraform apply
          │
          ▼
    Managed Resources
```

## Current Provider

The current implementation uses the **AWS provider**.

The Terraform configuration demonstrates management of:

* EC2 instances
* EBS storage volumes
* Security Groups
* Elastic IP resources
* Resource attachments and associations

AWS is the current provider implementation, not the definition of the IaC domain.

## Project Structure

```text
infrastructure-as-code/
├── README.md
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── terraform.tfvars.example
```

The `terraform/` directory contains the current infrastructure implementation.

## Applied Project

This capability is applied to the **Weekly Backup Infrastructure** project.

The project demonstrates how Infrastructure as Code can provision the infrastructure required for a dedicated backup environment.

[`Weekly Backup Infrastructure`](../backup/weekly-backup-infrastructure/)

## Future Providers

The IaC domain can be extended to other infrastructure providers, such as:

* AWS
* DigitalOcean
* Microsoft Azure
* Google Cloud

Each provider can have its own Terraform configuration while following the same Infrastructure as Code principles.

## Design Principles

The IaC practice in this portfolio is based on:

* **Automation** — infrastructure is provisioned through code.
* **Reproducibility** — infrastructure can be recreated from configuration.
* **Consistency** — infrastructure changes follow a controlled process.
* **Traceability** — infrastructure configuration is version-controlled.
* **Provider flexibility** — the IaC domain is not limited to a single infrastructure provider.
