provider "aws" {
  region = "us-east-1"
}

module "vpc_ec2" {
  source = "./modules/vpc_ec2"

  aws_region               = "us-east-1"
  project_name             = "myproject"
  vpc_cidr                 = "10.0.0.0/16"
  public_subnet_cidr       = "10.0.1.0/24"
  private_subnet_cidr      = "10.0.2.0/24"
  availability_zone        = "us-east-1a"
  ami_id                   = "ami-0c02fb55956c7d316" # Example Amazon Linux 2
  instance_type            = "t2.micro"
  create_key_pair           = true
  create_private_instance   = true
  s3_bucket_name            = "cmdstk-terrafrom-syed-1"
  tags = {
    Environment = "Dev"
    Project     = "TerraformAssignment"
    Owner       = "syed1"
  }
}
