# ========================================================
# Root Terraform Configuration - AWS Infrastructure + S3
# ========================================================

module "vpc_ec2" {
  source = "./modules/terraform-aws-vpc-ec2"

  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  instance_type     = var.instance_type
  create_key_pair   = var.create_key_pair
  project_name      = var.project_name
  ami_id            = var.ami_id
  aws_region        = var.aws_region
}


# ========================================================
# S3 Bucket new one
# ========================================================

resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-bucket"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


