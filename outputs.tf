# ========================================================
# Root Outputs (clean, unique)
# ========================================================

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc_ec2.vpc_id
}

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = module.vpc_ec2.subnet_id
}

output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.vpc_ec2.public_ip
}

output "private_key_pem" {
  description = "Private key PEM content (if new key created)"
  value       = module.vpc_ec2.private_key_pem
  sensitive   = true
}

output "private_key_file_path" {
  description = "Private key file path saved by module"
  value       = module.vpc_ec2.private_key_file_path
}

output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.this.bucket
}
