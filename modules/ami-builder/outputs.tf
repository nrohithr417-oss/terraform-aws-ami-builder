########################################
# Image Builder Pipeline Outputs
########################################

output "image_pipeline_arn" {
  description = "ARN of the EC2 Image Builder pipeline"
  value       = aws_imagebuilder_image_pipeline.this.arn
}

output "image_pipeline_name" {
  description = "Name of the EC2 Image Builder pipeline"
  value       = aws_imagebuilder_image_pipeline.this.name
}

########################################
# Image Recipe Outputs
########################################

output "image_recipe_arn" {
  description = "ARN of the EC2 Image Builder recipe"
  value       = aws_imagebuilder_image_recipe.this.arn
}

output "image_recipe_name" {
  description = "Name of the EC2 Image Builder recipe"
  value       = aws_imagebuilder_image_recipe.this.name
}

########################################
# Component Output
########################################

output "software_installation_component_arn" {
  description = "ARN of the Image Builder software installation component"
  value       = aws_imagebuilder_component.software_installation.arn
}

########################################
# Infrastructure Configuration Outputs
########################################

output "infrastructure_configuration_arn" {
  description = "ARN of the Image Builder infrastructure configuration"
  value       = aws_imagebuilder_infrastructure_configuration.this.arn
}

output "infrastructure_configuration_name" {
  description = "Name of the Image Builder infrastructure configuration"
  value       = aws_imagebuilder_infrastructure_configuration.this.name
}

########################################
# Distribution Configuration Outputs
########################################

output "distribution_configuration_arn" {
  description = "ARN of the Image Builder distribution configuration"
  value       = aws_imagebuilder_distribution_configuration.this.arn
}

output "distribution_configuration_name" {
  description = "Name of the Image Builder distribution configuration"
  value       = aws_imagebuilder_distribution_configuration.this.name
}

########################################
# IAM Outputs
########################################

output "image_builder_role_arn" {
  description = "ARN of the IAM role used by EC2 Image Builder"
  value       = aws_iam_role.image_builder.arn
}

output "image_builder_instance_profile_name" {
  description = "Name of the EC2 Image Builder instance profile"
  value       = aws_iam_instance_profile.image_builder.name
}

########################################
# AMI Naming Output
########################################

output "ami_name_pattern" {
  description = "Name pattern used for generated AMIs"
  value       = "${local.name_prefix}-{{ imagebuilder:buildDate }}"
}