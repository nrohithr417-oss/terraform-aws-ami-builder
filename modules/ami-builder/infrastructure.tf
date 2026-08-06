########################################
# EC2 Image Builder Infrastructure
# Configuration
########################################

resource "aws_imagebuilder_infrastructure_configuration" "this" {
  name        = local.image_infrastructure_name
  description = "Infrastructure configuration for building the custom ${var.project_name} AMI"

  instance_profile_name = aws_iam_instance_profile.image_builder.name

  instance_types = [
    var.instance_type
  ]

  terminate_instance_on_failure = true

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.image_builder,
    aws_iam_role_policy_attachment.ssm
  ]
}