########################################
# Image Builder Pipeline Outputs
########################################

output "image_pipeline_arn" {
  description = "ARN of the EC2 Image Builder pipeline"
  value       = module.ami_builder.image_pipeline_arn
}

output "image_pipeline_name" {
  description = "Name of the EC2 Image Builder pipeline"
  value       = module.ami_builder.image_pipeline_name
}

########################################
# Image Recipe Outputs
########################################

output "image_recipe_arn" {
  description = "ARN of the EC2 Image Builder recipe"
  value       = module.ami_builder.image_recipe_arn
}

output "image_recipe_name" {
  description = "Name of the EC2 Image Builder recipe"
  value       = module.ami_builder.image_recipe_name
}

########################################
# Image Builder Component Output
########################################

output "software_installation_component_arn" {
  description = "ARN of the Image Builder software installation component"
  value       = module.ami_builder.software_installation_component_arn
}

########################################
# Infrastructure Configuration Outputs
########################################

output "infrastructure_configuration_arn" {
  description = "ARN of the Image Builder infrastructure configuration"
  value       = module.ami_builder.infrastructure_configuration_arn
}

output "infrastructure_configuration_name" {
  description = "Name of the Image Builder infrastructure configuration"
  value       = module.ami_builder.infrastructure_configuration_name
}

########################################
# Distribution Configuration Outputs
########################################

output "distribution_configuration_arn" {
  description = "ARN of the Image Builder distribution configuration"
  value       = module.ami_builder.distribution_configuration_arn
}

output "distribution_configuration_name" {
  description = "Name of the Image Builder distribution configuration"
  value       = module.ami_builder.distribution_configuration_name
}

########################################
# IAM Outputs
########################################

output "image_builder_role_arn" {
  description = "ARN of the IAM role used by EC2 Image Builder"
  value       = module.ami_builder.image_builder_role_arn
}

output "image_builder_instance_profile_name" {
  description = "Name of the EC2 Image Builder instance profile"
  value       = module.ami_builder.image_builder_instance_profile_name
}

########################################
# AMI Naming Output
########################################

output "ami_name_pattern" {
  description = "Name pattern used for generated AMIs"
  value       = module.ami_builder.ami_name_pattern
}