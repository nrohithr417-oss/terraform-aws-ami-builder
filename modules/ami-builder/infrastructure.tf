########################################
# EC2 Image Builder Infrastructure
########################################

resource "aws_imagebuilder_infrastructure_configuration" "this" {
  name        = "${local.name_prefix}-infrastructure"
  description = "Infrastructure configuration for building the ${local.name_prefix} AMI"

  instance_profile_name = aws_iam_instance_profile.image_builder.name
  instance_types        = [var.instance_type]

  subnet_id          = var.subnet_id
  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : null

  terminate_instance_on_failure = var.terminate_instance_on_failure

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.image_builder,
    aws_iam_role_policy_attachment.ssm,
    aws_iam_role_policy_attachment.cloudwatch
  ]
}