# AWS SSM Windows Password Rotation

## Overview
You can find the original article on [AWS Blog](https://aws.amazon.com/blogs/mt/password-rotation-for-windows-on-amazon-ec2-made-easy-with-ec2rescue/)

## Terraform version
Module compatible with Terraform `0.12`


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app\_name | Application Name | string | `"windows_password_rotation"` | no |
| create\_kms\_key | Create a dedicated KMS key or use default `alias/aws/ssm` | bool | `"false"` | no |
| enabled\_cloudwatch\_task | create task to periodically install cloudwatch logs | bool | `"true"` | no |
| schedule | SSM maintenance window schedule | string | `"rate(1 day)"` | no |
| ssm\_target\_key | SSM maintenance window target Tags key | string | `"tag:PasswordRotate"` | no |
| ssm\_target\_values | SSM maintenance window target Tags values | list | `[ "Enabled" ]` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | IAM role ARN |
| iam\_role\_name | IAM role name |
| kms\_id | KMS id used |
| ssm\_maintenance\_window | SSM maintenance window id |
| ssm\_maintenance\_window\_target | SSM maintenance window target id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


