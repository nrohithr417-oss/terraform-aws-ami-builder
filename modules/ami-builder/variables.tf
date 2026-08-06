variable "project_name" {
  description = "Name of the project used for resource naming"
  type        = string

  validation {
    condition     = length(trimspace(var.project_name)) >= 3
    error_message = "The project name must contain at least 3 characters."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition = contains(
      ["dev", "qa", "stage", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, qa, stage, or prod."
  }
}

variable "ami_version" {
  description = "Semantic version assigned to the Image Builder recipe"
  type        = string
  default     = "1.0.0"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.ami_version))
    error_message = "AMI version must use semantic version format, such as 1.0.0."
  }
}

variable "parent_image" {
  description = "Base AMI ARN or Image Builder managed image ARN"
  type        = string
  default     = "arn:aws:imagebuilder:ap-south-1:aws:image/amazon-linux-2023-x86/x.x.x"
}

variable "instance_type" {
  description = "EC2 instance type used temporarily during the AMI build"
  type        = string
  default     = "t3.small"
}

variable "root_volume_size" {
  description = "Root EBS volume size for the custom AMI in GiB"
  type        = number
  default     = 20

  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 100
    error_message = "Root volume size must be between 8 and 100 GiB."
  }
}

variable "subnet_id" {
  description = "Subnet ID used by the temporary Image Builder instance"
  type        = string
  default     = null
  nullable    = true
}

variable "security_group_ids" {
  description = "Security group IDs assigned to the temporary Image Builder instance"
  type        = list(string)
  default     = []
}

variable "terminate_instance_on_failure" {
  description = "Terminate the temporary build instance when the build fails"
  type        = bool
  default     = true
}

variable "pipeline_enabled" {
  description = "Enable or disable the Image Builder pipeline"
  type        = bool
  default     = true
}

variable "pipeline_schedule_expression" {
  description = "Schedule expression used to run the Image Builder pipeline"
  type        = string
  default     = "cron(0 2 ? * SUN *)"
}

variable "distribution_regions" {
  description = "AWS regions where the completed AMI will be distributed"
  type        = list(string)
  default     = ["ap-south-1"]

  validation {
    condition     = length(var.distribution_regions) > 0
    error_message = "At least one AMI distribution region must be provided."
  }
}

variable "ami_name_prefix" {
  description = "Prefix used when naming generated AMIs"
  type        = string
  default     = "custom-linux-ami"
}

variable "ssm_parameter_name" {
  description = "SSM Parameter Store name used to publish the latest AMI ID"
  type        = string
  default     = "/ami-builder/dev/latest-ami-id"
}

variable "component_version" {
  description = "Version assigned to Image Builder components"
  type        = string
  default     = "1.0.0"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.component_version))
    error_message = "Component version must use semantic version format, such as 1.0.0."
  }
}

variable "tags" {
  description = "Additional tags applied to supported AWS resources"
  type        = map(string)
  default     = {}
}