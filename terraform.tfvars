aws_region          = "us-east-1"
project_name        = "cmdstk-aws-training"
vpc_cidr            = "10.0.0.0/16"
subnet_cidr         = "10.0.1.0/24"
availability_zone   = "us-east-1a"
ami_id              = "ami-07860a2d7eb515d9a"
instance_type       = "t2.micro"
create_key_pair     = true
existing_key_name   = null
map_public_ip_on_launch = true

tags = {
  Environment = "dev"
  Owner       = "cmdstk"
  Project     = "Terraform VPC EC2"
}

ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }
]
