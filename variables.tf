
variable "app_name" {
  description = "Application Name"
  default     = "windows_password_rotation"
  type        = string
}


variable "create_kms_key" {
  default = false
  type    = bool
}


variable "enabled_cloudwatch_task" {
  default = true
  type    = bool

}
