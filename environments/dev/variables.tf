########################################
# Project Configuration
########################################

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-ami-builder"

  validation {
    condition     = length(trimspace(var.project_name)) >= 3
    error_message = "Project name must contain at least 3 characters."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition = contains(
      ["dev", "qa", "stage", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, qa, stage, or prod."
  }
}

########################################
# AMI Configuration
########################################

variable "ami_version" {
  description = "Version of the Image Builder recipe"
  type        = string
  default     = "1.0.1"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.ami_version))
    error_message = "AMI version must use semantic version format, such as 1.0.1."
  }
}

variable "component_version" {
  description = "Version of the Image Builder component"
  type        = string
  default     = "1.0.1"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+$", var.component_version))
    error_message = "Component version must use semantic version format, such as 1.0.1."
  }
}

########################################
# Build Instance Configuration
########################################

variable "instance_type" {
  description = "Temporary EC2 instance type used during the AMI build"
  type        = string
  default     = "t3.small"

  validation {
    condition     = can(regex("^[a-z0-9]+\\.[a-z0-9]+$", var.instance_type))
    error_message = "Instance type must be valid, such as t3.small."
  }
}

variable "root_volume_size" {
  description = "AMI root volume size in GiB"
  type        = number
  default     = 20

  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 100
    error_message = "Root volume size must be between 8 and 100 GiB."
  }
}

########################################
# Image Builder Pipeline
########################################

variable "pipeline_enabled" {
  description = "Enable the Image Builder pipeline"
  type        = bool
  default     = true
}

variable "pipeline_schedule_expression" {
  description = "Image Builder pipeline schedule expression"
  type        = string
  default     = "cron(0 2 ? * SUN *)"

  validation {
    condition = (
      can(regex("^cron\\(.+\\)$", var.pipeline_schedule_expression)) ||
      can(regex("^rate\\(.+\\)$", var.pipeline_schedule_expression))
    )

    error_message = "Pipeline schedule must use an AWS cron(...) or rate(...) expression."
  }
}

########################################
# AMI Distribution
########################################

variable "distribution_regions" {
  description = "Regions where the completed AMI will be distributed"
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

########################################
# Resource Tags
########################################

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}