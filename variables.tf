
variable "app_name" {
  description = "Application Name"
  default     = "windows_password_rotation"
  type        = string
}

variable "create_kms_key" {
  description = "Create a dedicated KMS key or use default `alias/aws/ssm`"
  default     = false
  type        = bool
}

variable "enabled_cloudwatch_task" {
  description = "create task to periodically install cloudwatch logs"
  default     = true
  type        = bool

}

variable "ssm_target_key" {
  description = "SSM maintenance window target Tags key"
  default     = "tag:PasswordRotate"
  type        = string
}

variable "ssm_target_values" {
  description = "SSM maintenance window target Tags values"
  default     = ["Enabled"]
  type        = list
}

