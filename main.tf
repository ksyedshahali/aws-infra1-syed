module "vpc_ec2" {
  source = "./modules/terraform-aws-vpc-ec2"

  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  availability_zone   = var.availability_zone
  instance_type   = var.instance_type
  create_key_pair = var.create_key_pair
  project_name        = var.project_name
  ami_id =  var.ami_id
  aws_region = var.aws_region
}
