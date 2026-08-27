# Storage

Practical experience implementing persistent storage for AWS workloads using Amazon EBS.

## Technologies

- Amazon EBS
- EBS volumes
- ext4 filesystem
- Linux mount management
- `/etc/fstab`
- AWS CLI
- Terraform

## Capabilities Demonstrated

- Persistent block storage provisioning
- EBS volume configuration
- Storage capacity planning
- Linux filesystem creation
- Filesystem mounting
- Persistent mounts using UUID
- Storage validation after reboot
- Encrypted EBS storage
- Infrastructure provisioning with Terraform

## EBS Storage

Amazon EBS provides persistent block storage that can be attached to EC2 instances.

Storage is separated from the EC2 compute layer, allowing the lifecycle of the compute resource and persistent data storage to be managed independently.

## Linux Storage Configuration

The attached EBS volume was:

1. Detected using `lsblk`
2. Formatted with the ext4 filesystem
3. Mounted under `/backup`
4. Configured in `/etc/fstab`
5. Validated after a system reboot

The filesystem was referenced by UUID to avoid relying on device naming.

## Infrastructure as Code

The EBS volume and its attachment to the EC2 instance are managed declaratively with Terraform.

The configuration separates the operating-system root volume from dedicated persistent storage.

## Project Application

Storage capabilities were applied to the following AWS infrastructure project:

- [Weekly Backup Infrastructure](../../../backup/weekly-backup-infrastructure/)
