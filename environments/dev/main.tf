module "ami_builder" {
  source = "../../modules/ami-builder"

  project_name = var.project_name
  environment  = var.environment

  ami_version       = var.ami_version
  component_version = var.component_version

  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size

  pipeline_enabled             = var.pipeline_enabled
  pipeline_schedule_expression = var.pipeline_schedule_expression

  distribution_regions = var.distribution_regions

  tags = var.tags
}