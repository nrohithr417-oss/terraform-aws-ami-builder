# AMI Build Guide

## Overview

This project creates a reusable custom Amazon Machine Image using Terraform and AWS EC2 Image Builder.

The AMI includes:

- Docker
- Docker Compose
- Terraform
- AWS Systems Manager Agent
- Nginx
- Certbot
- OpenSSL
- Operating-system security hardening

## Prerequisites

Install and configure:

- Terraform 1.8 or newer
- AWS CLI
- Git
- An AWS account with permissions for:
  - EC2 Image Builder
  - IAM
  - EC2
  - Systems Manager
  - CloudWatch Logs

Verify AWS authentication:

```powershell
aws sts get-caller-identity