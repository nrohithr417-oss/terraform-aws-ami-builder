########################################
# Latest Ubuntu 22.04 LTS AMI
########################################

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

########################################
# EC2 Image Builder Recipe
########################################

resource "aws_imagebuilder_image_recipe" "this" {
  name         = local.image_recipe_name
  description  = "Ubuntu AMI with Docker, Docker Compose, Terraform, Nginx, SSL tools, SSM Agent, and OS hardening"
  version      = var.ami_version
  parent_image = data.aws_ami.ubuntu.id

  component {
    component_arn = aws_imagebuilder_component.software_installation.arn
  }

  block_device_mapping {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      encrypted             = true
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
    }
  }

  working_directory = "/tmp"

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}