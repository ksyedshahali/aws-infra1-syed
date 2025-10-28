# -------------------------
# Outputs
# -------------------------
output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_id" {
  value = aws_subnet.this.id
}

output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_key_pem" {
  description = "Private key PEM content if key pair was created"
  value       = var.create_key_pair ? tls_private_key.this[0].private_key_pem : null
  sensitive   = true
}

output "private_key_file_path" {
  description = "Local file path where private key is saved"
  value       = var.create_key_pair ? local_file.private_key[0].filename : null
}
