output "vpc_id" {
  description = "Created VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Created public subnet ID"
  value       = module.vpc.subnet_id
}

output "security_group_id" {
  description = "EC2 security group ID"
  value       = module.security_group.sg_id
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "EC2 public IPv4 address"
  value       = module.ec2.public_ip
}

output "ec2_private_ip" {
  description = "EC2 private IPv4 address"
  value       = module.ec2.private_ip
}

output "elastic_ip" {
  description = "Elastic IP address"
  value       = module.ec2.elastic_ip
}
