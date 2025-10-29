aws_region            = "us-east-1"
project_name          = "cmdstk-aws-training"
vpc_cidr              = "10.0.0.0/16"
public_subnet_cidr    = "10.0.1.0/24"
private_subnet_cidr   = "10.0.2.0/24"
availability_zone     = "us-east-1a"
ami_id = "ami-0c94855ba95c71c99"
instance_type         = "t2.micro"
create_key_pair       = true
create_private_instance = true

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

tags = {
  Environment = "Dev"
  Project     = "TerraformAssignment"
  Owner       = "syed1"
}
