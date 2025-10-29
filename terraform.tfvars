aws_region           = "us-east-1"
project_name         = "cmdstk-aws-training"
vpc_cidr             = "10.0.0.0/16"
subnet_cidr          = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
availability_zone    = "us-east-1a"
ami_id               = "ami-0c55b159cbfafe1f0"  # Example Amazon Linux 2
instance_type        = "t2.micro"
create_key_pair      = true
create_private_instance = false

tags = {
  Environment = "Dev"
  Project     = "CMDSTK AWS Training"
}
