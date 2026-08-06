########################################
# EC2 Image Builder Pipeline
########################################

resource "aws_imagebuilder_image_pipeline" "this" {
  name        = "${local.name_prefix}-pipeline"
  description = "Image pipeline for building the ${local.name_prefix} custom AMI"

  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn

  status = var.pipeline_enabled ? "ENABLED" : "DISABLED"

  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 60
  }

  schedule {
    schedule_expression                = var.pipeline_schedule_expression
    pipeline_execution_start_condition = "EXPRESSION_MATCH_ONLY"
  }

  tags = local.common_tags
}