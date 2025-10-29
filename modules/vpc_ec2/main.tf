# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(var.tags, { Name = "${var.project_name}-vpc" })
}

# -------------------------
# Subnets
# -------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "${var.project_name}-public-subnet" })
}

resource "aws_subnet" "private" {
  count             = var.create_private_instance ? 1 : 0
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "${var.project_name}-private-subnet" })
}

# -------------------------
# Internet Gateway & Route Table
# -------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(var.tags, { Name = "${var.project_name}-igw" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = merge(var.tags, { Name = "${var.project_name}-rt-public" })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# Security Group for Public EC2 (Dynamic)
# -------------------------
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.this.id
  name   = "${var.project_name}-public-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.project_name}-public-sg" })
}

# -------------------------
# Security Group for Private EC2 (Dynamic, optional)
# -------------------------
resource "aws_security_group" "private_sg" {
  count  = var.create_private_instance ? 1 : 0
  vpc_id = aws_vpc.this.id
  name   = "${var.project_name}-private-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.project_name}-private-sg" })
}

# -------------------------
# Key Pair
# -------------------------
resource "tls_private_key" "this" {
  count     = var.create_key_pair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  count      = var.create_key_pair ? 1 : 0
 key_name = "${var.project_name}-key-${timestamp()}"
  public_key = tls_private_key.this[0].public_key_openssh
}

resource "local_file" "private_key" {
  count           = var.create_key_pair ? 1 : 0
  content         = tls_private_key.this[0].private_key_pem
  filename = "${path.module}/${var.project_name}-key-${timestamp()}.pem"
  file_permission = "0600"
}


# -------------------------
# Public EC2
# -------------------------
resource "aws_instance" "public" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = var.create_key_pair ? aws_key_pair.this[0].key_name : var.existing_key_name
  associate_public_ip_address = true

  tags = merge(var.tags, { Name = "${var.project_name}-public-ec2" })
}

# -------------------------
# Private EC2
# -------------------------
resource "aws_instance" "private" {
  count                      = var.create_private_instance ? 1 : 0
  ami                        = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = aws_subnet.private[0].id
  vpc_security_group_ids     = [aws_security_group.private_sg[0].id]
  key_name                   = var.create_key_pair ? aws_key_pair.this[0].key_name : var.existing_key_name
  associate_public_ip_address = false

  tags = merge(var.tags, { Name = "${var.project_name}-private-ec2" })
}

# -------------------------
# S3 Bucket
# -------------------------
resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-bucket"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
