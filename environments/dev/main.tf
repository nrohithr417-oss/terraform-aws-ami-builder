provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

module "ami_builder" {
  source = "../../modules/ami-builder"

  project_name = var.project_name
  environment  = var.environment

  ami_version      = var.ami_version
  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size

  pipeline_enabled             = var.pipeline_enabled
  pipeline_schedule_expression = var.pipeline_schedule_expression

  distribution_regions = var.distribution_regions

  ami_name_prefix = "terraform-custom-ami"

  ssm_parameter_name = "/${var.project_name}/${var.environment}/latest-ami-id"

  tags = var.tags
}