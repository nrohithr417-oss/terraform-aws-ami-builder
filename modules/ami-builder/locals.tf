locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "ami-builder"
    },
    var.tags
  )

  component_directory = "${path.module}/components"

  install_component_file    = "${local.component_directory}/install-software.yml"
  hardening_component_file  = "${local.component_directory}/harden-os.yml"
  validation_component_file = "${local.component_directory}/validate-ami.yml"

  ami_name = "${var.ami_name_prefix}-${var.environment}-{{ imagebuilder:buildDate }}"
}