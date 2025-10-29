output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc_ec2.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc_ec2.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID (if created)"
  value       = module.vpc_ec2.private_subnet_id
}

output "public_ec2_id" {
  description = "Public EC2 instance ID"
  value       = module.vpc_ec2.public_ec2_id
}

output "public_ec2_ip" {
  description = "Public IP of the public EC2 instance"
  value       = module.vpc_ec2.public_ec2_ip
}

output "private_ec2_id" {
  description = "Private EC2 instance ID (if created)"
  value       = module.vpc_ec2.private_ec2_id
}

output "private_ec2_ip" {
  description = "Private IP of the private EC2 instance (if created)"
  value       = module.vpc_ec2.private_ec2_ip
}

output "private_key_pem" {
  description = "Private key PEM content if key pair was created"
  value       = module.vpc_ec2.private_key_pem
  sensitive   = true
}

output "s3_bucket_name" {
  description = "S3 bucket name created by Terraform"
  value       = module.vpc_ec2.s3_bucket_name
}
