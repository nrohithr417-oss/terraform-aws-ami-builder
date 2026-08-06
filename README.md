\# Terraform AWS AMI Builder



Reusable Terraform module for building a custom EC2 AMI using AWS EC2 Image Builder.



\## Features



\- Ubuntu 22.04 base image

\- Docker

\- Docker Compose

\- Terraform

\- AWS SSM Agent

\- Nginx

\- Certbot

\- OpenSSL

\- Basic operating-system hardening

\- Versioned Image Builder recipe

\- Scheduled Image Builder pipeline

\- Multi-region AMI distribution

\- IAM role and instance profile



\## Project Structure



```text

terraform-aws-ami-builder/

├── environments/

│   └── dev/

├── modules/

│   └── ami-builder/

├── .gitignore

├── MODULES.md

└── README.md

