## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.image_builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.image_builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.image_builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_imagebuilder_component.software_installation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_component) | resource |
| [aws_imagebuilder_distribution_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_distribution_configuration) | resource |
| [aws_imagebuilder_image_pipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image_pipeline) | resource |
| [aws_imagebuilder_image_recipe.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image_recipe) | resource |
| [aws_imagebuilder_infrastructure_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_infrastructure_configuration) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name_prefix"></a> [ami\_name\_prefix](#input\_ami\_name\_prefix) | Prefix used when naming generated AMIs | `string` | `"custom-linux-ami"` | no |
| <a name="input_ami_version"></a> [ami\_version](#input\_ami\_version) | Semantic version assigned to the Image Builder recipe | `string` | `"1.0.0"` | no |
| <a name="input_component_version"></a> [component\_version](#input\_component\_version) | Semantic version assigned to Image Builder components | `string` | `"1.0.0"` | no |
| <a name="input_distribution_regions"></a> [distribution\_regions](#input\_distribution\_regions) | AWS regions where the completed AMI will be distributed | `list(string)` | <pre>[<br/>  "ap-south-1"<br/>]</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type temporarily used during the AMI build | `string` | `"t3.small"` | no |
| <a name="input_parent_image"></a> [parent\_image](#input\_parent\_image) | Base AMI ID, Image Builder image ARN, or SSM parameter reference | `string` | `"arn:aws:imagebuilder:ap-south-1:aws:image/amazon-linux-2023-x86/x.x.x"` | no |
| <a name="input_pipeline_enabled"></a> [pipeline\_enabled](#input\_pipeline\_enabled) | Enable or disable the Image Builder pipeline | `bool` | `true` | no |
| <a name="input_pipeline_schedule_expression"></a> [pipeline\_schedule\_expression](#input\_pipeline\_schedule\_expression) | Schedule expression used to run the Image Builder pipeline | `string` | `"cron(0 2 ? * SUN *)"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project used for resource naming | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Root EBS volume size for the custom AMI in GiB | `number` | `20` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs assigned to the temporary Image Builder instance | `list(string)` | `[]` | no |
| <a name="input_ssm_parameter_name"></a> [ssm\_parameter\_name](#input\_ssm\_parameter\_name) | SSM Parameter Store name used to publish the latest AMI ID | `string` | `"/ami-builder/dev/latest-ami-id"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID used by the temporary Image Builder instance | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags applied to supported AWS resources | `map(string)` | `{}` | no |
| <a name="input_terminate_instance_on_failure"></a> [terminate\_instance\_on\_failure](#input\_terminate\_instance\_on\_failure) | Terminate the temporary build instance when the build fails | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_name_pattern"></a> [ami\_name\_pattern](#output\_ami\_name\_pattern) | Name pattern used for generated AMIs |
| <a name="output_distribution_configuration_arn"></a> [distribution\_configuration\_arn](#output\_distribution\_configuration\_arn) | ARN of the Image Builder distribution configuration |
| <a name="output_distribution_configuration_name"></a> [distribution\_configuration\_name](#output\_distribution\_configuration\_name) | Name of the Image Builder distribution configuration |
| <a name="output_image_builder_instance_profile_name"></a> [image\_builder\_instance\_profile\_name](#output\_image\_builder\_instance\_profile\_name) | Name of the EC2 Image Builder instance profile |
| <a name="output_image_builder_role_arn"></a> [image\_builder\_role\_arn](#output\_image\_builder\_role\_arn) | ARN of the IAM role used by EC2 Image Builder |
| <a name="output_image_pipeline_arn"></a> [image\_pipeline\_arn](#output\_image\_pipeline\_arn) | ARN of the EC2 Image Builder pipeline |
| <a name="output_image_pipeline_name"></a> [image\_pipeline\_name](#output\_image\_pipeline\_name) | Name of the EC2 Image Builder pipeline |
| <a name="output_image_recipe_arn"></a> [image\_recipe\_arn](#output\_image\_recipe\_arn) | ARN of the EC2 Image Builder recipe |
| <a name="output_image_recipe_name"></a> [image\_recipe\_name](#output\_image\_recipe\_name) | Name of the EC2 Image Builder recipe |
| <a name="output_infrastructure_configuration_arn"></a> [infrastructure\_configuration\_arn](#output\_infrastructure\_configuration\_arn) | ARN of the Image Builder infrastructure configuration |
| <a name="output_infrastructure_configuration_name"></a> [infrastructure\_configuration\_name](#output\_infrastructure\_configuration\_name) | Name of the Image Builder infrastructure configuration |
| <a name="output_software_installation_component_arn"></a> [software\_installation\_component\_arn](#output\_software\_installation\_component\_arn) | ARN of the Image Builder software installation component |
