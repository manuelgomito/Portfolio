output "backup_instance_id" {
  description = "ID of the backup EC2 instance"
  value       = aws_instance.backup_server.id
}

output "backup_private_ip" {
  description = "Private IP address of the backup server"
  value       = aws_instance.backup_server.private_ip
}

output "backup_elastic_ip" {
  description = "Elastic IP address of the backup server"
  value       = aws_eip.backup_server.public_ip
}

output "backup_storage_volume_id" {
  description = "ID of the dedicated backup EBS volume"
  value       = aws_ebs_volume.backup_storage.id
}
