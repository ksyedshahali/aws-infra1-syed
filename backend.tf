terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket  = "cmdstk-terraform-remote-backend"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}