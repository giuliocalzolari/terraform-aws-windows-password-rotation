# AWS SSM Windows Password Rotation



## Terraform version
Module compatible with Terraform `0.12`


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app\_name | Application Name | string | `"windows_password_rotation"` | no |
| create\_kms\_key |  | bool | `"false"` | no |
| enabled\_cloudwatch\_task |  | bool | `"true"` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | IAM role ARN |
| iam\_role\_name | IAM role name |
| kms\_id | KMS id used |
| ssm\_maintenance\_window | SSM maintenance window id |
| ssm\_maintenance\_window\_target | SSM maintenance window target id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


