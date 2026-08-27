# AWS CLI

Practical use of the AWS Command Line Interface to inspect and manage AWS infrastructure from a Linux environment.

## Environment

- Ubuntu 24.04 LTS
- WSL2
- AWS CLI v2
- Linux x86_64

## Capabilities Demonstrated

- AWS account and region configuration
- EC2 resource inspection
- VPC inspection
- Subnet inspection
- Security Group management
- Elastic IP inspection
- Infrastructure troubleshooting
- AWS CLI integration with Terraform

## Example

Infrastructure resources were inspected and managed using commands such as:

    aws ec2 describe-instances
    aws ec2 describe-security-groups
    aws ec2 describe-subnets
    aws ec2 describe-addresses

AWS CLI was also used alongside Terraform to validate the resulting infrastructure.

## Related Project

- [Weekly Backup Infrastructure](../../../backup/weekly-backup-infrastructure/)
