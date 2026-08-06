########################################
# AMI Distribution Configuration
########################################

resource "aws_imagebuilder_distribution_configuration" "this" {
  name        = "${local.name_prefix}-distribution"
  description = "Distribution configuration for the ${local.name_prefix} custom AMI"

  dynamic "distribution" {
    for_each = toset(var.distribution_regions)

    content {
      region = distribution.value

      ami_distribution_configuration {
        name        = local.ami_name
        description = "Custom AMI generated for ${local.name_prefix}"

        ami_tags = local.common_tags
      }
    }
  }

  tags = local.common_tags
}