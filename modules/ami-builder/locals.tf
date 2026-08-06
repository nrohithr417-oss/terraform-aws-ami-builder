########################################
# Locals
########################################

locals {

  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Terraform   = "true"
    },
    var.tags
  )

  image_recipe_name         = "${local.name_prefix}-recipe"
  image_pipeline_name       = "${local.name_prefix}-pipeline"
  image_infrastructure_name = "${local.name_prefix}-infrastructure"
  image_distribution_name   = "${local.name_prefix}-distribution"
  image_component_name      = "${local.name_prefix}-component"

  ami_name = "${local.name_prefix}-{{ imagebuilder:buildDate }}"
}