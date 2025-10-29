

module "vpc_ec2" {
  source = "./modules/vpc_ec2"

  aws_region             = var.aws_region
  project_name           = var.project_name
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidr     = var.public_subnet_cidr
  private_subnet_cidr    = var.private_subnet_cidr
  availability_zone      = var.availability_zone
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  create_key_pair        = var.create_key_pair
  create_private_instance= var.create_private_instance
  ingress_rules          = var.ingress_rules
  tags                   = var.tags
}
