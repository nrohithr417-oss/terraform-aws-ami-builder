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

variable "component_version" {
  description = "Semantic version assigned to Image Builder components"
  type        = string
  default     = "1.0.0"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.component_version))
    error_message = "Component version must use semantic version format, such as 1.0.0."
  }
}

variable "parent_image" {
  description = "Base AMI ID, Image Builder image ARN, or SSM parameter reference"
  type        = string
  default     = "arn:aws:imagebuilder:ap-south-1:aws:image/amazon-linux-2023-x86/x.x.x"

  validation {
    condition     = length(trimspace(var.parent_image)) > 0
    error_message = "Parent image must not be empty."
  }
}

variable "instance_type" {
  description = "EC2 instance type temporarily used during the AMI build"
  type        = string
  default     = "t3.small"

  validation {
    condition     = length(trimspace(var.instance_type)) > 0
    error_message = "Instance type must not be empty."
  }
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

  validation {
    condition = (
      var.subnet_id == null ||
      can(regex("^subnet-[0-9a-fA-F]+$", var.subnet_id))
    )

    error_message = "Subnet ID must be null or a valid value beginning with subnet-."
  }
}

variable "security_group_ids" {
  description = "Security group IDs assigned to the temporary Image Builder instance"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for security_group_id in var.security_group_ids :
      can(regex("^sg-[0-9a-fA-F]+$", security_group_id))
    ])

    error_message = "Every security group ID must begin with sg-."
  }
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

  validation {
    condition = (
      startswith(var.pipeline_schedule_expression, "cron(") ||
      startswith(var.pipeline_schedule_expression, "rate(")
    )

    error_message = "Pipeline schedule must be a valid cron(...) or rate(...) expression."
  }
}

variable "distribution_regions" {
  description = "AWS regions where the completed AMI will be distributed"
  type        = list(string)
  default     = ["ap-south-1"]

  validation {
    condition = (
      length(var.distribution_regions) > 0 &&
      alltrue([
        for region in var.distribution_regions :
        can(regex("^[a-z]{2}(-gov)?-[a-z]+-[0-9]+$", region))
      ])
    )

    error_message = "Provide at least one valid AWS region, such as ap-south-1."
  }
}

variable "ami_name_prefix" {
  description = "Prefix used when naming generated AMIs"
  type        = string
  default     = "custom-linux-ami"

  validation {
    condition     = length(trimspace(var.ami_name_prefix)) >= 3
    error_message = "AMI name prefix must contain at least 3 characters."
  }
}

variable "ssm_parameter_name" {
  description = "SSM Parameter Store name used to publish the latest AMI ID"
  type        = string
  default     = "/ami-builder/dev/latest-ami-id"

  validation {
    condition     = startswith(var.ssm_parameter_name, "/")
    error_message = "SSM parameter name must begin with a forward slash."
  }
}

variable "tags" {
  description = "Additional tags applied to supported AWS resources"
  type        = map(string)
  default     = {}
}