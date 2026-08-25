terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "backup_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "backup-server"
    Environment = "production-like"
    Purpose     = "weekly-backup"
    ManagedBy   = "Terraform"
  }
}

resource "aws_ebs_volume" "backup_storage" {
  availability_zone = var.availability_zone
  size              = var.backup_volume_size
  type              = "sc1"
  encrypted         = true

  tags = {
    Name        = "backup-storage"
    Environment = "production-like"
    Purpose     = "weekly-backup"
    ManagedBy   = "Terraform"
  }
}

resource "aws_volume_attachment" "backup_storage" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.backup_storage.id
  instance_id = aws_instance.backup_server.id
}

resource "aws_eip" "backup_server" {
  domain = "vpc"

  tags = {
    Name        = "backup-server-eip"
    Environment = "production-like"
    Purpose     = "weekly-backup"
    ManagedBy   = "Terraform"
  }
}

resource "aws_eip_association" "backup_server" {
  instance_id   = aws_instance.backup_server.id
  allocation_id = aws_eip.backup_server.id
}
