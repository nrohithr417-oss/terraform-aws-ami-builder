aws_region   = "ap-south-1"
project_name = "terraform-ami-builder"
environment  = "dev"

ami_version       = "1.0.1"
component_version = "1.0.1"

instance_type    = "t3.small"
root_volume_size = 20

pipeline_enabled             = true
pipeline_schedule_expression = "cron(0 2 ? * SUN *)"

distribution_regions = [
  "ap-south-1"
]

tags = {
  Owner      = "Rohith"
  Team       = "DevOps"
  CostCenter = "Learning"
}