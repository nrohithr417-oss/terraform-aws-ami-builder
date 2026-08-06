provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "terraform-aws-ami-builder"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}