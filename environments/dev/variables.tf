variable "aws_region" {
  description = "AWS region where the AMI Builder resources will be created"
  type        = string
  default     = "ap-south-1"

  validation {
    condition     = can(regex("^[a-z]{2}(-gov)?-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "The AWS region must be a valid region such as ap-south-1."
  }
}