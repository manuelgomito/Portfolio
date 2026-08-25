variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the Ubuntu Server instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 10
}

variable "backup_volume_size" {
  description = "Backup storage volume size in GB"
  type        = number
  default     = 150
}

variable "availability_zone" {
  description = "Availability Zone where the backup EBS volume will be created"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID assigned to the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name used for SSH access"
  type        = string
}
