########################################
# IAM Role for EC2 Image Builder
########################################

resource "aws_iam_role" "image_builder" {
  name = "${local.name_prefix}-image-builder-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.common_tags
}

########################################
# EC2 Instance Profile
########################################

resource "aws_iam_instance_profile" "image_builder" {
  name = "${local.name_prefix}-instance-profile"
  role = aws_iam_role.image_builder.name

  tags = local.common_tags
}

########################################
# IAM Policy Attachments
########################################

# EC2 Image Builder
resource "aws_iam_role_policy_attachment" "image_builder" {
  role       = aws_iam_role.image_builder.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder"
}

# AWS Systems Manager (SSM)
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.image_builder.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# CloudWatch Agent
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.image_builder.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}