# -------------------------
# VPC
# -------------------------
output "vpc_id" {
  value = aws_vpc.this.id
}

# -------------------------
# Subnets
# -------------------------
output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = var.create_private_instance ? aws_subnet.private[0].id : null
}

# -------------------------
# EC2 Instances
# -------------------------
output "public_ec2_id" {
  value = aws_instance.public.id
}

output "public_ec2_ip" {
  value = aws_instance.public.public_ip
}

output "private_ec2_id" {
  value = var.create_private_instance ? aws_instance.private[0].id : null
}

output "private_ec2_ip" {
  value = var.create_private_instance ? aws_instance.private[0].private_ip : null
}

# -------------------------
# Key Pair
# -------------------------
output "private_key_pem" {
  description = "Private key PEM content if key pair was created"
  value       = var.create_key_pair ? tls_private_key.this[0].private_key_pem : null
  sensitive   = true
}

# -------------------------
# S3 Bucket
# -------------------------
output "s3_bucket_name" {
  value = aws_s3_bucket.this.bucket
}
